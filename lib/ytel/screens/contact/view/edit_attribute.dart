import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/widget/common_snackbar.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class EditAttribute extends StatefulWidget {
  dynamic snapshot;

  EditAttribute({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<EditAttribute> createState() =>
      _EditAttributeState(snapshot);
}

class _EditAttributeState extends State<EditAttribute> {
  dynamic snapshot;

  
  

  var apiList;
  bool _isLoading = false;
  String defaultValue = "Keyword";

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _EditAttributeState(this.snapshot);
  @override
  Widget build(BuildContext context) {
    


    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    print(snapshot);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text(
          "Edit Attribute",
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

            // a dropdown button for "Type" attribute which has 6 options "Keyword","text","Number","Decimal","Date","Boolean"
            _dropdownButton(),
            

            
          ],
        ),
      ),
    ));
  }

  Widget _dropdownButton()
  {
    return Container(
      width: 300,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Type",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value: defaultValue,
        items: [
          DropdownMenuItem(
            child: Text("Keyword"),
            value: "Keyword",
          ),
          DropdownMenuItem(
            child: Text("Text"),
            value: "Text",
          ),
          DropdownMenuItem(
            child: Text("Number"),
            value: "Number",
          ),
          DropdownMenuItem(
            child: Text("Decimal"),
            value: "Decimal",
          ),
          DropdownMenuItem(
            child: Text("Date"),
            value: "Date",
          ),
          DropdownMenuItem(
            child: Text("Boolean"),
            value: "Boolean",
          ),
        ],
        onChanged: (value) {
          setState(() {
            defaultValue = value.toString();
          });
        },
      ),
    );
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
      String phone_no,String fname, String lname, String email, String address, String city, String state, String pincode,
      String country
  ) async {
    String contactId = snapshot['contactId'];
    String url = "https://api.ytel.com/api/v4/contact/$contactId/";

    Map<String, dynamic> body = {
      "extData":{
        "firstname": fname,
        "lastname": lname,
        "address1": address,
        "city1": city,
        "state1": state,
        "country1": country,
        "zip1": pincode,
        "email1": email,
        "phonenumber1": phone_no,
        },"keys":[phone_no]
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
        if (data['status'] ==false) {
          

          CommonSnackBar.showSnackbar("Error", data['error'][0]['message']);
          throw Exception(data['error'][0]['message']);
        } else {
          CommonSnackBar.showSnackbar("Sucess", "Contact Updated successfully");
        }
        //Show success message

      }
    } catch (e) {
      logger.e(e);
    }
  }
}
