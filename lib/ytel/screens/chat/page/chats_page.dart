
import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '../model/user.dart';
import '../widget/chat_body_widget.dart';
import '../widget/chat_header_widget.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String dropdownValue = "7 days";

  String dropdownValue2 = "Newest";

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
          
        ),
        body: SafeArea(
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
                           Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children:[
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
                    items: <String>['7 days', '30 days', '90 days']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
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
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
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
                    items: <String>['Newest', 'Oldest']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          
                        ),
                        ),
                      );
                    }).toList(),
                  ),
                   
                  
                ]
              ),
              SizedBox(height: 10),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
