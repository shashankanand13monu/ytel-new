import 'package:flutter/material.dart';

import '../model/message.dart';

class MyChatWidget extends StatelessWidget {
  final String message;
  final String isMe;

  const MyChatWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(17);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe=="in" ? MainAxisAlignment.end : MainAxisAlignment.start,

      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isMe == "in" ? Color.fromARGB(255, 33, 133, 247) : Color.fromARGB(255, 190, 232, 251),
            borderRadius: isMe == "in"
                ? BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                    bottomLeft: radius,
                  )
                : BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                    bottomRight: radius,
                  ),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe == "in" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(color: isMe == "in" ? Colors.white : Colors.black),
            textAlign: isMe == "in" ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
