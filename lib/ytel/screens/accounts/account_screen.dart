import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/screens/Number_Management/view/edit_number.dart';
import 'package:ytel/ytel/services/interceptors.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

import '../../helper/constants/strings.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // List<GetNumbersAPI>? apiList;

  var apiList;

  //Generate random number int

  bool search_pressed = false;
  List<String> number_list = [];
  List<String> number_list2 = [];
  String query = '';
  //Make a map of list of numbers
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNumbersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.primaryTextColor,
          title: Text('Accounts', style: TextStyle(color: Colors.white)),
          //Search icon in the end of appbar
          actions: [
            IconButton(
              onPressed: () async {},
              icon: Icon(Icons.download),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  search_pressed = !search_pressed;
                });
              },
              icon: Icon(Icons.search),
            ),
            //Download icon
          ],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: apiList == null
            ? Center(child: CircularProgressIndicator())
            : _body());
  }

  Widget __numBody() {
    return TabBarView(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              // if (apiList != null) getNumbers(),
              //Show Loading icon and text "Loading.."while fetching data
              if (apiList == null)
                Center(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Loading..'),
                      ],
                    ),
                  ),
                ),

              //Table heading
              if (apiList != null)
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text("Actions   ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              //title of the table: "Phone Numbers", "Status", "Action"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'AgentId',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget to get Numbers from API
  Widget getNumbers() {
    return Expanded(
      child: ListView.builder(
          itemCount: number_list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // mapTheNumber();
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(number_list[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            )),

                        //Arrao icon to show the status of the number
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // NumberDetalis(apiList: apiList, index: index);

                                // print(index);
                              },
                              icon: Icon(Icons.edit,
                                  color: Colors.grey, size: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                // NumberDetalis(apiList: apiList, index: index);

                                // Get.to(NumberDetalis(
                                //   phoneNo: number_list[index],
                                // ));

                                // print(index);
                              },
                              icon: Icon(Icons.info,
                                  color: Colors.grey, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget getNumShortCode() {
    /* Display "AgentId", Status(Cupertino Switch) and "action" which has 3 functinalities "copy"," edit" and "Delete" from API*/
    // try and catch loading

    return Expanded(
      child: ListView.builder(
          itemCount:
              apiList['payload'].length == null ? 0 : apiList['payload'].length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shadowColor: Colors.white,
              child: ListTile(
                leading: //text from Payload list

                    Text(apiList['payload'][index]['phoneNumber']),
                subtitle: Switch(
                  value: true,
                  onChanged: (value) {
                    print(value);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.copy),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      iconSize: 15,
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //API Call to get Numbers
  Future<void> getNumbersFromAPI() async {
    String url =
        'https://api.ytel.com/ams/v2/accounts/subaccounts/7c8693c6-976e-4324-9123-2c1d811605f9/';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);
    String acc= StorageUtil.getString(StringHelper.ACCOUNT_ID);
    
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
        /* 
      Example Response

  [
    {
        "id": "33d666f4-e172-06c0-b22f-bfd02d37e19d",
        "name": "KyleTest001",
        "domain": null,
        "emailAddress": "kyle.test001@ytel.com",
        "contactId": 139577,
        "ytelCompanyId": 111810,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": null,
        "source": "m360",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1566946805771,
        "modifyAt": 1567397023310,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
    },
    {
        "id": "e54ac75e-1eba-23d8-92b9-89bdbd170f9f",
        "name": "KyleTest001",
        "domain": null,
        "emailAddress": "kyle.test001@ytel.com",
        "contactId": 139577,
        "ytelCompanyId": 111810,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": null,
        "source": "m360",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1566948290732,
        "modifyAt": 1567397023335,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
    },
    {
        "id": "026a4c8f-0000-481c-a100-08a227757381",
        "name": "Third times the charm. So far its working.",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592858976530,
        "modifyAt": 1592858976530,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "376f9710-63a2-46e6-b17f-8f3d40e7cbce",
        "name": "New subbaccount test",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592859055749,
        "modifyAt": 1592859055749,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "75dacb47-5572-424a-b891-3c1074594804",
        "name": "Bob Test Account",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+19496900429",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1664920603658,
        "modifyAt": 1664920603658,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "8bb8f4f9-cf98-4d03-8467-cae903e087c2",
        "name": "Testing another one",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592859360239,
        "modifyAt": 1592859360239,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "8de9c3e3-5f93-4ef2-bb83-926bf925e273",
        "name": "Testing Fake Account",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592858960747,
        "modifyAt": 1592858960747,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "a44040e9-da58-47d1-b40e-e84599a72ff2",
        "name": "my sub",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1604438933817,
        "modifyAt": 1604438933817,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
    },
    {
        "id": "b0e3dbdd-5c20-42a2-a692-02c791c4977b",
        "name": "Fifth time is when we have issues",
        "domain": "aol.com",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+19495555555",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592859077056,
        "modifyAt": 1592859077056,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "b8fa50ef-9228-4bbc-93c3-285631843c73",
        "name": "test subaccount",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+19496900429",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1589842392492,
        "modifyAt": 1626841907002,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
    },
    {
        "id": "ba2a7a72-0313-41aa-b2b6-13fae9082eaf",
        "name": "Testing Subaccount",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+19496900429",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1651205952286,
        "modifyAt": 1651205952286,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "bb1c97b4-9ca0-44c0-b6c3-a04bc2b87b81",
        "name": "Subaccount Tester",
        "domain": "fakesite@test.com",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1592858934225,
        "modifyAt": 1592858934225,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "c76a6f52-d6f7-48be-b114-c1b29e371f5f",
        "name": "Sunny Test",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+11111111111",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1600371255487,
        "modifyAt": 1600371255487,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "d1018c0a-7e31-4da9-be10-19f5594489ff",
        "name": "SUB-ACCOUNT",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+107517041013",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1644357485078,
        "modifyAt": 1644357485078,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "d63d0a3c-921c-465f-ba58-d0cddae9d5ba",
        "name": "rohtas",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1668012361114,
        "modifyAt": 1668012361114,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "f944b14f-135e-4464-bb1c-c5bec0fe8d95",
        "name": "Post release test",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1604437747154,
        "modifyAt": 1604437747154,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "f9e90d06-8172-4aa6-8b57-3057c4966d21",
        "name": "Katelyn Testing",
        "domain": "",
        "emailAddress": null,
        "contactId": null,
        "ytelCompanyId": null,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "+19496900429",
        "source": "interact",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1631641063425,
        "modifyAt": 1631641063425,
        "firstName": null,
        "lastName": null,
        "status": "active"
    },
    {
        "id": "c391096a-c263-961f-2ab1-4054d55b5d54",
        "name": "Kyletest001",
        "domain": null,
        "emailAddress": "kyle.test001@ytel.com",
        "contactId": 139577,
        "ytelCompanyId": 111810,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": null,
        "source": "m360",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1566947041332,
        "modifyAt": 1567397023366,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
    }
]

Account Details
var data= json.loads(response.content)
print name

for i in data:
    print(i['id'],i['name'],i['domain'],i['emailAddress'],i['contactId'],i['ytelCompanyId'],i['isParentAcct'],i['parentAcctId'],i['phone'],i['source'],i['rateTableRefId'],i['smsOptIn'],i['createAt'],i['modifyAt'],i['firstName'],i['lastName'],i['status'])

  
    



    
    Length of the response = data.__len__()
      */
        var data = json.decode(result.body);

        setState(() {
          print(data);
          print("----------------");
          apiList = data;
        });
      }
    } catch (e) {
      //Display Dialog Box of error message with "Logout" button
      logger.e(e.toString());
    }
  }

  Widget _body() => ListView.builder(
        itemCount: apiList.length,
        itemBuilder: (context, index) => ExpansionTile(
          tilePadding: const EdgeInsets.only(left: 15, right: 0),
          title: Text(apiList[index]['name']),
          children: [
            // Name
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]['emailAddress'] == null
                        ? ""
                        : apiList[index]['emailAddress'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // contactId
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Contact Id: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      apiList[index]['contactId'].toString() == null
                          ? "null"
                          : apiList[index]['contactId'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // // Created Date
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "Parent Acct Id: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]['parentAcctId'].toString() == null
                        ? "null"
                        : apiList[index]['parentAcctId'].toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]['status'] == null
                        ? "null"
                        : apiList[index]['status'].toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            //   child: Row(
            //     children: [
            //       const Text(
            //         "purchaseDate ",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 17,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       Text(
            //         apiList['payload'][index]['purchaseDate'] == null
            //             ? "null"
            //             : apiList['payload'][index]['purchaseDate'].toString(),
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            //   child: Row(
            //     children: [
            //       const Text(
            //         "heartbeatMethod: ",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 17,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       Text(
            //         apiList['payload'][index]['heartbeatMethod'] == null
            //             ? "null"
            //             : apiList['payload'][index]['heartbeatMethod'],
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            //   child: Row(
            //     children: [
            //       const Text(
            //         "smsMethod: ",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 17,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       Text(
            //         apiList['payload'][index]['smsMethod'] == null
            //             ? "null"
            //             : apiList['payload'][index]['smsMethod'],
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            //   child: Row(
            //     children: [
            //       const Text(
            //         "hangupCallbackMethod: ",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 17,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       Text(
            //         apiList['payload'][index]['hangupCallbackMethod'] == null
            //             ? "null"
            //             : apiList['payload'][index]['hangupCallbackMethod'],
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            //Edit button to edit number
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Display a button with a icon

                  CupertinoButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      print("Edit button pressed");
                      Get.to(EditPhoneNumber(
                        phoneId: apiList['payload'][index]['phoneNumber'],
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
