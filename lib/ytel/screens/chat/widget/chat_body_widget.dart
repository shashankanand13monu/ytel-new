
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../page/chat_page.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];

          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 75,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatPage(user: user),
                    ));
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.urlAvatar),
                  ),
                  title: Text(user.name,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.blue,
                        
                      )),
                      
                      trailing: Icon(Icons.more_vert,color: Colors.black,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
            ],
          );
        },
        itemCount: users.length,
      );
}
