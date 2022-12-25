import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class PurchaseSpecificNumber extends StatefulWidget {
  PurchaseSpecificNumber({Key? key}) : super(key: key);

  @override
  State<PurchaseSpecificNumber> createState() => _PurchaseSpecificNumberState();
}

class _PurchaseSpecificNumberState extends State<PurchaseSpecificNumber> {
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController numset= TextEditingController();
  final TextEditingController cnam = TextEditingController();

  

  @override
  void initState() {
    super.initState();
  }

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _PurchaseSpecificNumberState();
  @override
  Widget build(BuildContext context) {
    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text("Purchase Specific Number",
            style: TextStyle(color: Colors.white)),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _inboundVoice(),
          ],
        ),
      ),
    );
  }

  Widget _inboundVoice() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
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
                Text("Phone Number",
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
              controller: phoneNo,
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
                Text("Number Set",
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
              controller: numset,
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
                Text("CNAM",
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
              controller: cnam,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
               
              ),
            ),
            SizedBox(
              height: 15,
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
                phoneNo.text,
                numset.text,
                cnam.text,
                
              );
            },
            child: Text(
              'Buy',
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
    String phoneNo,
    String numSet,
    String cnam,
  ) async {
    String url = "https://api.ytel.com/api/v4/number/purchase/";

    Map<String, dynamic> body = {"phoneNumber":[phoneNo],"numberSetId":numSet,"cnam":cnam};

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

      /*
      {"status":false,"count":0,"page":0,"error":[{"code":"404","message":"Number not found","moreInfo":null}]}
     */

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          Get.snackbar("Error", data['error'][0]['message'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          throw Exception(data['error'][0]['message']);
        }
        //Show success message
        Get.snackbar(
          "Success",
          "Number Purchased successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
