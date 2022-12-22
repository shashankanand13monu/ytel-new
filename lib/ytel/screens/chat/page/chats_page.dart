import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/auth/controller/chat_view_controller.dart';
import 'package:ytel/ytel/screens/auth/controller/number_list_controller.dart';
import 'package:ytel/ytel/screens/auth/controller/start_convo_controller.dart';
import 'package:ytel/ytel/screens/chat/page/my_chats.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';
import '../../../helper/constants/strings.dart';
import '../../../services/interceptors.dart';
import '../../../utils/storage_utils.dart';
import '../api/firebase_api.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

import '../widget/chat_header_widget.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String dropdownValue = "7 days";
  var apiList;
  List<String> inbox = [];
  List<int>status = [];


  AsyncSnapshot<dynamic> snap =
      AsyncSnapshot.withData(ConnectionState.none, null);

  String dropdownValue2 = "Newest";

  //Textediting controller with defalut value as : +14075444480
  TextEditingController _tocontroller =
      TextEditingController(text: "+14075444480");
  TextEditingController _fromcontroller =
      TextEditingController(text: "+12013315855");
  TextEditingController _msgcontroller = TextEditingController();

  //initState
  void initState() {
    super.initState();
    //Get the list of numbers
    inboxApi();

  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Inbox',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          //2 icons for "Plus icon" and "Inbox icon"
          actions: [
            IconButton(
              onPressed: () {
                //Show 2 more options
                Get.defaultDialog(
                  title: "Inbox",
                  content: Column(
                    children: [
                      ListTile(
                        title: Text("Select Inbox"),
                        onTap: ()  {
                          Get.back();
                          displaySMS();
                        },
                      ),
                      ListTile(
                        title: Text("Inbox Management"),
                        onTap: () {
                          Get.back();

                          displaySMSDetails();
                        },
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.inbox,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                startConversation(context);
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // 2 Tabs for "Open" and "Closed" chats
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: Colors.blue,
                  child: TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Open",
                      ),
                      Tab(
                        text: "Closed",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    open(),
                    closed(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );

  Widget open() {
    return SafeArea(
      child: StreamBuilder<List<User>>(
        stream: FirebaseApi.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return buildText('Something Went Wrong Try later');
              } else {
                final users = snapshot.data;

                if (users!.isEmpty) {
                  return buildText('No Users Found');
                } else
                  return Column(
                    children: [
                      // ChatHeaderWidget(users: users),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              value: dropdownValue,
                              dropdownColor: Colors.blue,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white),
                              iconSize: 23,
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                '7 days',
                                '30 days',
                                '90 days'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              // Background color of the dropdown menu
                              dropdownColor: Colors.blue,
                              value: dropdownValue2,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white),
                              iconSize: 26,
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue2 = newValue!;
                                });
                              },
                              items: <String>[
                                'Newest',
                                'Oldest'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ]),
                      SizedBox(height: 10),
                      // ChatBodyWidget(users: users),
                      body(),
                    ],
                  );
              }
          }
        },
      ),
    );
  }

  Widget body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: chat_view_controller.data(dropdownValue),
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
            snap = snapshot;
            // store all numbers from the data in a list

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!["payload"].length,
                        itemBuilder: (context, int index) {
                          int id = index;
                          if (dropdownValue2 == 'Oldest') {
                            id = snapshot.data["payload"].length - index - 1;
                          }

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
                              child: GestureDetector(
                                onTap: () {
                                  //Go to My_Chat page with getx method

                                  Get.to(
                                      MyChats(
                                        contactId: snapshot.data["payload"][id]
                                                ["contact"]["contactId"]
                                            .toString(),
                                        contactName: snapshot.data["payload"]
                                                        [id]["contact"]
                                                        ["extData"]["firstname"]
                                                    .toString() ==
                                                'null'
                                            ? snapshot.data["payload"][id]
                                                    ["contact"]["extData"]
                                                    ["phonenumber1"]
                                                .toString()
                                            : snapshot.data["payload"][id]
                                                    ["contact"]["extData"]
                                                    ["firstname"]
                                                .toString(),
                                        index: index,
                                        snapshot: snap,
                                      ),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      IconHelper.icons[10],
                                      color: ColorHelper.colors[7],
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      snapshot.data["payload"][id]["contact"]
                                                      ["extData"]["firstname"]
                                                  .toString() ==
                                              'null'
                                          ? snapshot.data["payload"][id]
                                                  ["contact"]["extData"]
                                                  ["phonenumber1"]
                                              .toString()
                                          : snapshot.data["payload"][id]
                                                  ["contact"]["extData"]
                                                  ["firstname"]
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: ColorHelper.colors[0],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        },
      ),
    ));
  }

  Widget closed() {
    return Container(
      child: Center(
        child: Text(
          "No Chats",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void startConversation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Text"),
            content: SingleChildScrollView(
              child: Column(
                //a dropdownmenu to select the contact
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("To"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: _tocontroller,
                      decoration: InputDecoration(
                        hintText: "Enter Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text("From"),
                  // Textfield to type number
                  //hide the bottom border
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextFormField(
                      controller: _fromcontroller,
                      decoration: InputDecoration(
                        hintText: "Enter Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _msgcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your message here",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // A row of buttons to send the message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"),
                        style: ElevatedButton.styleFrom(
                          primary: ColorHelper.colors[7],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          sendSms(_tocontroller.text, _fromcontroller.text,
                              _msgcontroller.text);
                        },
                        child: Text("Send"),
                        style: ElevatedButton.styleFrom(
                          primary: ColorHelper.colors[0],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> sendSms(String to, String from, String text) async {
    String url = '${StringHelper.BASE_URL}api/v4/conversation';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    Map<String, dynamic> body = {
      "text": text,
      "to": to,
      "source": {"sourceId": "ytelapi"},
      "metadata": {
        "contactId": "a136e329-0ff6-4813-9319-c13068748414",
        "publish": true
      },
      "from": from,
      "numberSetId": null
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

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          Get.snackbar("Error", data['error'][0]['message'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        } else {
          Get.snackbar(
            "Success",
            "Successfully sent message",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> inboxApi() async {
    String url = 'https://api.ytel.com/api/v4/inbox/name/';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");

        var data = json.decode(result.body);

        if (data['status'] == false) {
          Get.snackbar("Error", data['error'][0]['message'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          throw Exception(data['error'][0]['message']);
        }

        setState(() {
          apiList = data;
          // add data['payload]['name'] to the list of inboxes

          for (var i = 0; i < data['payload'].length; i++) {
            inbox.add(data['payload'][i]['name']);
            status.add(data['payload'][i]['status']);
          }
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> displaySMS() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select Inbox"),
            content: Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                itemCount: inbox.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(inbox[index]),
                    onTap: () {},
                  );
                },
              ),
            ),
          );
        });
  }

  Future<void> displaySMSDetails() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Inbox Detals"),
            content: Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                itemCount: inbox.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inbox[index]),
                      //if apiList['payload][index][status]==0 the switch off else on
                      Switch(
                        value: status[index]==0?false:true,
                        onChanged: (value) {},
                      ),
                     
                    ],
                  );
                },
              ),
            ),
          );
        });
  }
}
