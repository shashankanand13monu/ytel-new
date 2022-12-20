
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/auth/controller/chat_view_controller.dart';
import 'package:ytel/ytel/screens/chat/page/my_chats.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';
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
  AsyncSnapshot<dynamic> snap =
      AsyncSnapshot.withData(ConnectionState.none, null);

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
                          // ChatBodyWidget(users: users),
                          body(),
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

  Widget body(){
  return Expanded(child: Center(
    child: FutureBuilder(
      future: chat_view_controller.data(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: ColorHelper.colors[6],strokeWidth: 1,),
          );
        }else if(snapshot.hasError){
          return Center(
            child: CircularProgressIndicator(color: ColorHelper.colors[6],strokeWidth: 1,),
          );
        }else{
          snap = snapshot;
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
                      itemCount : snapshot.data!["payload"].length,
                      itemBuilder: (context , int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                // border: Border.all(),

                            ),
                            child: GestureDetector(
                              onTap: (){
                               //Go to My_Chat page with getx method
                               
                                Get.to(MyChats(contactId: snapshot.data!["payload"][index.toInt()]["contact"]["contactId"].toString(),contactName: snapshot.data!["payload"][index.toInt()]["contact"]["extData"]["firstname"].toString(),index: index,snapshot: snap,),transition: Transition.rightToLeftWithFade);
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 5,),
                                  Icon(IconHelper.icons[10],color: ColorHelper.colors[7],
                                  size: 30,),
                                  SizedBox(width: 15,),
                                  Text(snapshot.data!["payload"][index.toInt()]["contact"]["extData"]["firstname"].toString(),style: TextStyle(
                                    fontSize: 20,
                                    color: ColorHelper.colors[0],
                                  ),),
                                  Expanded(child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                        onTap: (){
                                         // show more options for the chat like "Delete Chat","Block User","Archive Chat"
                                          showModalBottomSheet(
                                            
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                              ),
                                              backgroundColor: ColorHelper.colors[0],
                                              builder: (BuildContext context){
                                                
                                                return Container(
                                                  height: 200,
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(IconHelper.icons[11],color: ColorHelper.colors[8],),
                                                        title: Text("Delete Chat",style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorHelper.colors[8],
                                                        ),),
                                                        onTap: (){
                                                          //Delete Chat
                                                          
                                                          Get.back();
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(IconHelper.icons[12],color: ColorHelper.colors[8],),
                                                        title: Text("Block User",style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorHelper.colors[8],
                                                        ),),
                                                        onTap: (){
                                                          //Block User
                                                          
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(IconHelper.icons[14],color: ColorHelper.colors[8],),
                                                        title: Text("Archive Chat",style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorHelper.colors[8],
                                                        ),),
                                                        onTap: (){
                                                          //Archive Chat
                                                          
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                          );


                                         
                                        },
                                        child: Icon(IconHelper.icons[13],color: ColorHelper.colors[6],)),
                                  )),
                                  
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
}
