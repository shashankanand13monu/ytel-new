import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/widget/common_snackbar.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class CreateCnam extends StatefulWidget {
  CreateCnam({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateCnam> createState() => _CreateCnamState();
}

class _CreateCnamState extends State<CreateCnam> {
  final TextEditingController name = TextEditingController();
 

  var apiList;
  bool _isLoading = false;

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _CreateCnamState();
  @override
  Widget build(BuildContext context) {
    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text(
          "Request CNAM",
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
              putApi(
                name.text,
               
              );
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
  
  ) async {
    String url = "https://api.ytel.com/api/v4/callback/configuration/";

    Map<String, dynamic> body = {
     
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

          CommonSnackBar.showSnackbar("Error", data['error'][0]['message']);
          throw Exception(data['error'][0]['message']);
        } else {
          CommonSnackBar.showSnackbar(
              "Sucess", "Callback Created successfully");
        }
        //Show success message

      }
    } catch (e) {
      logger.e(e);
    }
  }
}
