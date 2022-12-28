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

class CreateAccount extends StatefulWidget {
  CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController name = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController phone_no = TextEditingController();

  var apiList;
  bool _isLoading = false;

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _CreateAccountState();
  @override
  Widget build(BuildContext context) {
    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text(
          "Create Account",
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
                Text("Website",
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
                Text("Phone No",
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
              controller: phone_no,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 20,
            ),
            //Display a button named "Save"
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
                website.text,
                phone_no.text,
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
    String website,
    String phone,
  ) async {
    String url = "https://api.ytel.com/ams/v2/accounts";

    Map<String, dynamic> body = {
      "domain": website,
      "name": name,
      "phone": phone_no.text,
      "isParentAcct": false,
      "source": "interact",
      "status": 1,
      "id": null
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
      print(data);
      if (response.statusCode == 200) {
        if (data['status'] != "active") {
          

          CommonSnackBar.showSnackbar("Error", data['message']);
          throw Exception(data['message']);
        } else {
          CommonSnackBar.showSnackbar("Sucess", "Account Created successfully");
        }
        //Show success message

      }
    } catch (e) {
      logger.e(e);
    }
  }
}
