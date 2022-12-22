import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/strings.dart';
import '../../../services/interceptors.dart';
import '../../../utils/storage_utils.dart';
import '../api/firebase_api.dart';

class NewMessageWidget extends StatefulWidget {
   String contactId;
   String accountId;
   String from;
   String to;

   NewMessageWidget({
    Key? key,
    required this.contactId,
    required this.accountId,
    required this.from,
    required this.to,
    
  }) : super(key: key);

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState(contactId,accountId,from, to);
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  String contactId;
  String accountId;
  String from;
  String to;

  _NewMessageWidgetState(this.contactId,this.accountId, this.from, this.to);
  void sendMessage() async {
    FocusScope.of(context).unfocus();

    sendSMS(_controller.text);

    _controller.clear();
  }

  Future<void> sendSMS(String text) async {
    String url = 'https://api.ytel.com/api/v4/conversation/?contactId=$contactId';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    Map<String, dynamic> body = {
      
    "accountSid": accountId,
    "from": from,
    "to": to,
    "text": text,
    "source": {
        "sourceId": "fsi"
    },
    "metadata": {
        
        "contactId": contactId,
        "publish": true
    }

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
          Get.back();
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }


  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 221, 230, 239),
                  labelText: 'Message',
                  //width
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(29),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
