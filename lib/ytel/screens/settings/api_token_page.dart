import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:ytel/ytel/screens/settings/controller/api_token_controller.dart';
import 'package:ytel/ytel/screens/settings/view/edit%20user.dart';

import '../../services/interceptors.dart';
import '../../utils/storage_utils.dart';

class ApiToken extends StatefulWidget {
  const ApiToken({Key? key}) : super(key: key);

  @override
  State<ApiToken> createState() => _ApiTokenState();
}

class _ApiTokenState extends State<ApiToken> {
  AsyncSnapshot<dynamic> snapshots = AsyncSnapshot<dynamic>.nothing();
  TextEditingController _tokenController = TextEditingController();
  TextEditingController _expireController = TextEditingController();
  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);
  var apiList = [];
  String newTokenGenerated = "null";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appbar(),
        body(),
      ],
    );
  }

  Widget appbar() {
    return AppBar(
      backgroundColor: ColorHelper.primaryTextColor,
      title: Text('Number Set', style: TextStyle(color: Colors.white)),
      //Search icon in the end of appbar
      actions: [
        IconButton(
          onPressed: () async {
            _createToken();
          },
          icon: Icon(Icons.add),
        ),
        //Download icon
      ],
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: api_token_controller.data(),
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
            snapshots = snapshot;
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
                                  IconHelper.icons[20],
                                  color: ColorHelper.colors[7],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  snapshot.data![index.toInt()]["description"]
                                              .toString()
                                              .length >
                                          20
                                      ? snapshot.data![index.toInt()]
                                                  ["description"]
                                              .toString()
                                              .substring(0, 20) +
                                          "..."
                                      : snapshot.data![index.toInt()]
                                              ["description"]
                                          .toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        _numberDetails(index);
                                      },
                                      child: Icon(
                                        IconHelper.icons[12],
                                        color: ColorHelper.colors[2],
                                      )),
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

  _numberDetails(int i) {
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
                      title: Text('Token Details',
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
                                                .toString()
                                                .length >
                                            45
                                        ? snapshots.data[i].values
                                                .elementAt(index)
                                                .toString()
                                                .substring(0, 20) +
                                            "..."
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

  _createToken() {
    //return a form dialog with 2 textfields and 1 submit button
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              //make rounded corners
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(26)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create Token'),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    height: 50,
                    child: TextField(
                      controller: _tokenController,
                      decoration: InputDecoration(
                        labelText: 'Token Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: _expireController,
                      decoration: InputDecoration(
                        labelText: 'Expire Days',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //submit button
                  ElevatedButton(
                      onPressed: () {
                        //call the api to create token
                        //then close the dialog
                        putApi(_tokenController.text,
                            int.parse(_expireController.text));

                        Get.back();
                      },
                      child: Text('Create'))
                ],
              ),
            ),
          );
        });
  }

  Future<void> putApi(String token, int day) async {
    String accId = StorageUtil.getString(StringHelper.ACCOUNT_ID);

    String url =
        "https://api.ytel.com/ams/v2/keys/account/$accId/jti/";

    Map<String, dynamic> body = {
      "description": token,
      "expirationInDay": day,
      "roles": ["api-owner"]
    };

    try {
      http.Response response = await http.post(
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
        if (data['encryptToken'] == null) {
          Get.snackbar(
            "Error",
            data['errorCode'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          setState(() {
            newTokenGenerated = data['encryptToken'];
            _showMessage(newTokenGenerated);
          });
        }
        // Get.back();
        // _showMessage(data['encryptToken'
      }
    } catch (e) {
      //show error message
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  _showMessage(String message) {
    //show a ModalBottomSheet with the new token with copy button
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
                      title: Text('Token Details',
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
                          itemCount: 1,
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  'Token',
                                  style: TextStyle(
                                      color: ColorHelper.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text for value

                                Text(message),
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
}
