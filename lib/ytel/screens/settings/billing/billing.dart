import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/screens/settings/billing/billing_controller.dart';
import '../../../helper/constants/icons.dart';
import '../../../helper/constants/strings.dart';
import '../../../helper/widget/common_snackbar.dart';
import '../../../services/interceptors.dart';
import '../../../utils/storage_utils.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  var apiList;
  TextEditingController _email = TextEditingController();
  TextEditingController _threshold = TextEditingController(text: "100");

  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.primaryTextColor,
          title: Text(
            "Billing",
            style: TextStyle(color: ColorHelper.colors[8]),
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: ColorHelper.colors[8],
            tabs: [
              Tab(
                text: " Payment History",
              ),
              Tab(
                text: "Pricing",
              ),
              Tab(
                text: "Add Funds",
              ),
              Tab(
                text: "Payment Methods",
              ),
              Tab(
                text: "Notifications",
              ),
              Tab(
                text: "Support Plan",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _paymentHistory(),
            _pricing(),
            Center(
              child: Text("Add Funds"),
            ),
            apiList == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorHelper.colors[6],
                      strokeWidth: 1,
                    ),
                  )
                : _paymentMethod(),
            _noifications(),
            _supportPlan(),
          ],
        ),
      ),
    );
  }

  _paymentHistory() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: billing_controller.data(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  IconHelper.icons[22],
                                  color: ColorHelper.colors[7],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(snapshot.data[index]['cardType']
                                    .toString()),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {},
                                      child: snapshot.data[index]['status'] ==
                                              "COMPLETED"
                                          ? Icon(
                                              IconHelper.icons[23],
                                              color: ColorHelper.colors[1],
                                            )
                                          : Icon(
                                              IconHelper.icons[21],
                                              color: ColorHelper.colors[2],
                                            )),
                                )),
                                SizedBox(
                                  width: 7,
                                ),
                                //Icon button

                                IconButton(
                                    onPressed: () {
                                      _paymentHistoryDetails(index, snapshot);
                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: ColorHelper.colors[0],
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }
        },
      ),
    ));
  }

  _pricing() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: billing_controller.pricing(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data['rateTableByContract'].length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  IconHelper.icons[22],
                                  color: ColorHelper.colors[7],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(snapshot.data['rateTableByContract'][index]
                                        ['description']
                                    .toString()),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                          onTap: () {
                                            _pricingDetails(index, snapshot);
                                          },
                                          child: Icon(
                                            IconHelper.icons[19],
                                            color: ColorHelper.colors[0],
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }
        },
      ),
    ));
  }

  Future<void> getNumbersFromAPI() async {
    String baseurl = StringHelper.BASE_URL;
    String accId = StorageUtil.getString(StringHelper.ACCOUNT_ID);
    String url = baseurl + 'ams/v2/payment/method/' + accId;
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");

        var data = json.decode(result.body);
        print(data);

        setState(() {
          apiList = data;
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  _paymentMethod() {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: "12345678" +
                  apiList[0]['card']['number'].toString().substring(4, 8),
              expiryDate: apiList[0]['card']['expiryMonth'].toString() +
                  "/" +
                  apiList[0]['card']['expiryYear'].toString(),
              cardHolderName: apiList[0]['card']['firstName'] +
                  ' ' +
                  apiList[0]['card']['lastName'],
              cvvCode: "123",
              cardType: apiList[0]['card']['cardType'] == "AMEX"
                  ? CardType.americanExpress
                  : apiList[0]['card']['cardType'] == "VISA"
                      ? CardType.visa
                      : CardType.mastercard,
              showBackView: false,
              isSwipeGestureEnabled: false,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),

            SizedBox(
              height: 20,
            ),

            //Add new card
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: ColorHelper.colors[0],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Add New Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentHistoryDetails(int i, AsyncSnapshot<dynamic> snapshots) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Payment Details',
                          style: TextStyle(
                              color: ColorHelper.primaryTextColor,
                              fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close)),
                    ),
                    Divider(
                      thickness: 1,
                    ),

                    //Listview.builder for rows
                    Container(
                      height: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data![i].length,
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  snapshots.data[i].keys
                                              .elementAt(index)
                                              .toString() ==
                                          null
                                      ? ''
                                      : snapshots.data[i].keys
                                          .elementAt(index)
                                          .toString(),
                                  style: TextStyle(
                                      color: ColorHelper.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text for value

                                Text(snapshots.data[i].values
                                            .elementAt(index)
                                            .toString() ==
                                        null
                                    ? ''
                                    : snapshots.data[i].values
                                        .elementAt(index)
                                        .toString()),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _pricingDetails(int i, AsyncSnapshot<dynamic> snapshots) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Pricing Details',
                          style: TextStyle(
                              color: ColorHelper.primaryTextColor,
                              fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close)),
                    ),
                    Divider(
                      thickness: 1,
                    ),

                    //Listview.builder for rows
                    Container(
                      height: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              snapshots.data!['rateTableByContract'][i].length,
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  snapshots.data['rateTableByContract'][i].keys
                                              .elementAt(index)
                                              .toString() ==
                                          null
                                      ? ''
                                      : snapshots
                                          .data['rateTableByContract'][i].keys
                                          .elementAt(index)
                                          .toString(),
                                  style: TextStyle(
                                      color: ColorHelper.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text for value

                                Text(snapshots.data['rateTableByContract'][i]
                                            .values
                                            .elementAt(index)
                                            .toString() ==
                                        null
                                    ? ''
                                    : snapshots
                                        .data['rateTableByContract'][i].values
                                        .elementAt(index)
                                        .toString()),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _supportPlan() {
    /*
     A paragraph with a View link in blue color "As a company Ytel is dedicated to providing quality support to all Ytel customers. We know that there are time where teams need additional dedicated support to run a successful business. At this time we provide the following support programs for additional support."
     */
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'As a company Ytel is dedicated to providing quality support to all Ytel customers. We know that there are time where teams need additional dedicated support to run a successful business. At this time we provide the following support programs for additional support.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Go to https://www.ytel.com/pricing/support to view all support plans',
              style: TextStyle(
                color: ColorHelper.colors[0],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _noifications() {
    // return a container with 2 text editing filed and a button
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'We will notify you when the account balance goes negative or drops below the low balance threshold.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
            ),
            Text(
              'Notification email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Low balance threshold',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: TextField(
                controller: _threshold,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  putApi(_email.text, int.parse(_threshold.text));
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> putApi(
    String email,
    int threshold,
  ) async {
    String accId =  StorageUtil.getString(StringHelper.ACCOUNT_ID);
    String url =
        StringHelper.BASE_URL + 'ams/v2/accounts/balanceAlert/' + accId;
    
      String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);


    Map<String, dynamic> body = {
      "balanceAlertAmount": threshold,
      "emailAddress": email,
    };

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if (data['status']!=null) {
          CommonSnackBar.showSnackbar("Error", data['message']);
          throw Exception(data['message']);
        } else {
          CommonSnackBar.showSnackbar("Sucess", "Updated successfully");
        }
        //Show success message

      }
    } catch (e) {
      logger.e(e);
    }
  }
}
