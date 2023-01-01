import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/widget/common_snackbar.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class EditCallback extends StatefulWidget {
  dynamic snapshot;

  EditCallback({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<EditCallback> createState() =>
      _EditCallbackState(snapshot);
}

class _EditCallbackState extends State<EditCallback> {
  dynamic snapshot;

  final TextEditingController name = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController method = TextEditingController();

  var apiList;
  bool _isLoading = false;

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _EditCallbackState(this.snapshot);
  @override
  Widget build(BuildContext context) {
    name.text = snapshot['name'] == null ? "" : snapshot['name'];
    website.text = snapshot['url'] == null ? "" : snapshot['url'];
    method.text = snapshot['httpMethod'] == null ? "" : snapshot['httpMethod'];

    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    print(snapshot);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text(
          "Edit Callback",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            )
          : _userEdit(),
    );
  }

  Widget _userEdit() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Text Form Field for "Friendly Name"
            _inboxSave(),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Name",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                //border color
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Request URL",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            //Display a form with 4 textfield named "Voice request URL","Voice Fallback URL","Hangup callback URL","heartbeat URL" with a side drop down button which has "POST" and "GET" as options and default value as "POST" with DropdownButtonHideUnderline

            TextFormField(
              controller: website,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Method",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: method,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _inboxSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 90,
          height: 50,
          child: FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              //Go back using getx
              Get.back();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        //Cancel button
        Container(
          width: 90,
          height: 50,
          child: FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              //Put API to edit fields
              putApi(name.text, website.text, method.text, snapshot['id']);
            },
            child: Text(
              'Save',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  Future<void> putApi(
    String name,
    String website,
    String method,
    String id,
  ) async {
    String url =
        "https://api.ytel.com/api/v4/callback/configuration/$id/";

    Map<String, dynamic> body = {
      "name": name,
      "enabled":true,
      "callbackServerConfigId":snapshot['callbackServerConfigId'],
      "httpMethod":method,
      "contentType":snapshot['contentType'],
      "eventType":snapshot['eventType'],
      "headers":{},
      "responseMapping":{},
      "errorResponseMapping":{},
      "failureStrategy":{"retryStrategy":"none","retryCount":1,"retryDelaySeconds":2},
      "successPath":"HTTP_OK",
      "successValue":"",
      "url":website,
    };

    try {
      http.Response response = await http.put(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        if (data['status'].runtimeType == String) {
          CommonSnackBar.showSnackbar(
            "Error",
            data['message'],
          );
          throw Exception(data['error'][0]['message']);
        }
        //Show success message
        CommonSnackBar.showSnackbar(
          "Success",
          "Callback updated successfully",
        );
        
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
