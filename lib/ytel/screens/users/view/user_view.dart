import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/helper/widget/custom_widget.dart';
import 'package:ytel/ytel/screens/contact/controller/contact_controller.dart';
import 'package:ytel/ytel/services/interceptors.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/strings.dart';
import '../../../utils/extension.dart';
//Import User Model


import '../../../utils/storage_utils.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int fromPage = 0;
  int toPage = 100;
  var apiList;

  List<bool> listOfRoles = [];
  //CAll APi
  /*
  [
    {
        "clientId": "10bb0c84-45a2-4d2c-9ca6-5b509a9c8ee5",
        "authToken": "**********",
        "clientSecret": "**********",
        "firstName": "Katelyn",
        "lastName": "QAteam",
        "displayName": null,
        "username": "katelyn+qateam@ytel.com",
        "password": "**********",
        "emailAddress": null,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "belongAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": null,
        "hashPassword": "**********",
        "avatar": null,
        "createAtInEpoch": "2022-10-31T19:45:17.089+00:00",
        "createAt": "2022-10-31T19:45:17Z",
        "webrtcNumber": "+19893246367",
        "inboxes": null,
        "ucaasExtension": null,
        "ucaasCode": null,
        "twoFactorKey": "**********",
        "twoFactorEnabled": null,
        "status": "active",
        "roles": [
            "contact-admin",
            "gi-agent",
            "webrtc-agent",
            "number-admin",
            "workflow-admin",
            "mdashboard",
            "settings-admin",
            "billing-admin",
            "basic-reports",
            "asset-admin"
        ]
    }
    }
  */

  Future<void> getNumbersFromAPI() async {
    // _isLoading = true;

    String url =
        'https://api.ytel.com/ams/v2/accounts/users/7c8693c6-976e-4324-9123-2c1d811605f9/';
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
        var data = json.decode(result.body);
        

        setState(() {
          // print(data);
          apiList = data;
          // _isLoading = false;
        });
      }
    } catch (e) {
      //Display Dialog Box of error message with "Logout" button
      Logger().e(e);
    }
  }

  @override
  void initState() {
    //TODO: implement UserData
    getNumbersFromAPI();

    super.initState();
    // getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _bottomBar(),
        body: apiList == null ? CircularProgressIndicator() : _body());
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
          color: ColorHelper.primaryTextColor,
        ),
        title: const Text(
          "Users",
        ),
      );

  Widget _bottomBar() => Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // More
            CustomPageButton(
              onTap: () {
                if (fromPage > 0) {
                  fromPage = fromPage - 100;
                  toPage = toPage - 100;
                  // getUserData(
                  //     {"from": fromPage, "size": toPage, "statements": []});
                }
                setState(() {
                  fromPage = 0;
                  toPage = 100;
                });
              },
              icon: FontAwesomeIcons.anglesLeft,
            ),

            // Single
            CustomPageButton(
              onTap: () {
                setState(() {
                  if (fromPage <= 100) {
                    fromPage = 0;
                  } else {
                    fromPage = fromPage - 100;
                  }
                  toPage = toPage - 100;
                });
                // getUserData(
                //     {"from": fromPage, "size": toPage, "statements": []});
              },
              icon: FontAwesomeIcons.angleLeft,
            ),

            Text(
              "$fromPage - $toPage",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),

            // Single
            CustomPageButton(
              onTap: () {
                setState(() {
                  if (fromPage <= 100) {
                    fromPage = 100;
                  } else {
                    fromPage = fromPage + 100;
                  }

                  fromPage = fromPage + 100;
                });
                // getUserData(
                //     {"from": fromPage, "size": toPage, "statements": []});
              },
              icon: FontAwesomeIcons.angleRight,
            ),

            //More
            CustomPageButton(
              onTap: () {
                // if (userController.userModel!.roles!.length > 100) {
                //   setState(() {
                //     fromPage = fromPage + 100;
                //     toPage = toPage + 100;
                //   });
                //   // getUserData(
                //   //     {"from": fromPage, "size": toPage, "statements": []});
                // }
              },
              icon: FontAwesomeIcons.anglesRight,
            ),
          ],
        ),
      );

  Widget _body() => ListView.builder(
        itemCount: apiList.length,
        itemBuilder: (context, index) => ExpansionTile(
          leading: //Image
              const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9s_a2xcXbll85cDRML6pNEzEDt5fUvs0OgA&usqp=CAU"),
          ),
          tilePadding: const EdgeInsets.only(left: 15, right: 0),
          title: Text(
            apiList[index]["firstName"],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          children: [
            // Name
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children:  [
                  Text(
                    "Name : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]["firstName"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // First Name
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children:  [
                  Text(
                    "Email : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]["username"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Created Date
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "Phone No. : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]["phone"],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  //Same for Webphone
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "Created At : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    apiList[index]["createAt"],
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
                  CupertinoSwitch(
                    activeColor: ColorHelper.primaryTextColor,
                    value: apiList[index]["status"]=="active"?true:false, 
                    onChanged: (val) {
                      // setState(() {
                      //   listOfCheckBox[index] = val!;
                      // });
                    },
                  ),
                ],
              ),
            ),

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
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
