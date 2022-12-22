import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/auth/controller/my_chats_controller.dart';
import 'package:ytel/ytel/screens/chat/page/info_page.dart';
import 'package:ytel/ytel/screens/chat/widget/my_chat_widget.dart';
import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';
import '../widget/new_message_widget.dart';

class MyChats extends StatefulWidget {
  String contactId;
  String contactName;
  int index;
  AsyncSnapshot<dynamic> snapshot;

  MyChats(
      {Key? key,
      required this.contactId,
      required this.contactName,
      required this.index,
      required this.snapshot})
      : super(key: key);

  @override
  State<MyChats> createState() => _MyChatsState(contactId, contactName, index,snapshot);
}

class _MyChatsState extends State<MyChats> {
  String contactId;
  String contactName;
  int index;
  AsyncSnapshot<dynamic> snapshot;
  bool isLoading = true;
  AsyncSnapshot<dynamic> chatSnapshot=AsyncSnapshot<dynamic>.nothing();

  
  

  _MyChatsState(this.contactId, this.contactName, this.index,this.snapshot);
  @override

  @override
  void dispose() {
    super.dispose();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          contactName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(InfoPage(
                snapshot: snapshot,
                index: index,
              ));
            },
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            body(),
          ],
        ),
      ),
    );

    
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );

  Widget body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: my_chats_controller.chatData(contactId),
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
            chatSnapshot = snapshot;
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
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data["payload"].length,
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
                              child: MyChatWidget(
                                  snapshot: snapshot,
                                  isMe: snapshot.data["payload"][index.toInt()]
                                          ["event"]["direction"]
                                      .toString(),index: index,),
                                      
                            ),
                          );
                        }),
                  ),
                  NewMessageWidget(
                    contactId: contactId,
                    accountId: chatSnapshot.data["payload"][0]["accountSid"],
                    from: chatSnapshot.data["payload"][0]["event"]["from"],
                    to: chatSnapshot.data["payload"][0]["event"]["to"],

                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
