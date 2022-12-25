import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ytel/ytel/screens/Number_Management/view/edit_number.dart';
import 'package:ytel/ytel/screens/Number_Management/view/purchase_specific_number.dart';
import 'package:ytel/ytel/screens/auth/controller/number_list_controller.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:csv/csv.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';

class PurchaseNumber extends StatefulWidget {
  const PurchaseNumber({super.key});

  @override
  State<PurchaseNumber> createState() => _PurchaseNumberState();
}

class _PurchaseNumberState extends State<PurchaseNumber> {
  List<String> method1 = ['Local', 'Toll Free'];
  int m1 = 0;
  List<String> method2 = ['Voice only', 'SMS'];
  int m2 = 0;
  List<String> method3 = ['1', '3', '5', '10', '20', '50', '100', '200', '500'];
  int m3 = 0;
  AsyncSnapshot<dynamic> snapshots = AsyncSnapshot<dynamic>.nothing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          _searchNo(),
          body(),
        ],
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: ColorHelper.primaryTextColor,
      title: Text('Purchase Number', style: TextStyle(color: Colors.white)),
      //Search icon in the end of appbar
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => PurchaseSpecificNumber());
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

  _searchNo() {
    return Container(
      child: Column(
        children: [
          //Dropdown menu with fields "Type" : "Local","Toll Free"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Type     ",
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: m1,
                      items: method1.map((String value) {
                        return DropdownMenuItem(
                          value: method1.indexOf(value),
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          m1 = value as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Capabilities  ",
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: m2,
                      items: method2.map((String value) {
                        return DropdownMenuItem(
                          value: method2.indexOf(value),
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          m2 = value as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Display  ",
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: m3,
                      items: method3.map((String value) {
                        return DropdownMenuItem(
                          value: method3.indexOf(value),
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          m3 = value as int;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: number_list_controller.numberPurchase(
            method1[m1], method2[m2], method3[m3]),
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
            if (snapshot.data['status'] == false) {
              return Center(
                child: Text("No Data Found", style: TextStyle(fontSize: 16)),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data['payload'].length,
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
                                  IconHelper.icons[0],
                                  color: ColorHelper.colors[7],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(snapshot.data!['payload'][index]
                                        ['phoneNumber']
                                    .toString()),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        _numberDetails(index);
                                      },
                                      child: Icon(
                                        IconHelper.icons[19],
                                        color: ColorHelper.colors[7],
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
                      title: Text('Number Details',
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
                          itemCount: snapshots.data!['payload'][i].length,
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  snapshots.data['payload'][i].keys
                                              .elementAt(index)
                                              .toString() ==
                                          null
                                      ? ''
                                      : snapshots.data['payload'][i].keys
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

                                Text(snapshots.data['payload'][i].values
                                            .elementAt(index)
                                            .toString() ==
                                        null
                                    ? ''
                                    : snapshots.data['payload'][i].values
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
}
