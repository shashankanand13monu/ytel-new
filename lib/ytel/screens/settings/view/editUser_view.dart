import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../helper/widget/common_snackbar.dart';
import '../../../utils/storage_utils.dart';



class EditUserDetails extends StatefulWidget {
  dynamic snapshot;
  

  EditUserDetails({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState(snapshot);
}

class _EditUserDetailsState extends State<EditUserDetails> {
  dynamic snapshot;
 


  final TextEditingController first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone_no = TextEditingController();
  
  var apiList;
  bool _isLoading = false;

 

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _EditUserDetailsState(this.snapshot);
  @override
  Widget build(BuildContext context) {
    first_name.text = snapshot['firstName']==null?"":snapshot['firstName'];
    last_name.text = snapshot['lastName']==null?"":snapshot['lastName'];
    email.text = snapshot['username']==null?"":snapshot['username'];
    phone_no.text = snapshot['phone']==null?"":snapshot['phone'];

  
    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title:
            Text("Edit User" ,style: 
            TextStyle(color: Colors.white),),
       
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: ColorHelper.colors[6],
                strokeWidth: 1,
              ),
            ):
                _userEdit(),
          
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
                Text("First Name",
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
              controller: first_name,
              
              decoration: InputDecoration(
                hintText: snapshot['firstName'],
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
                Text("Last Name",
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
              controller: last_name,
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
                Text("Email",
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
              controller: email,
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
              controller: phone_no,
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
                  first_name.text,
                  last_name.text,
                  email.text,
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

  

  Future<void> putApi(String first_name, String last_name, String email,
      String phone_no) 
    async {
    String url = "https://api.ytel.com/ams/v2/users";

    Map<String, dynamic> body = {

  "firstName":first_name,
  "lastName":last_name,
  "phone":phone_no,
  "roles":["contact-admin","gi-agent","number-admin","workflow-admin","settings-admin","billing-admin","basic-reports","asset-admin"],
  "status":"active",
  "username":email,
    
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

      if (response.statusCode == 200) {
        if (data['status'] !="active") {
          

        CommonSnackBar.showSnackbar("Error", data['message']);

          throw Exception(data['error'][0]['message']);
        }
        //Show success message
       
        CommonSnackBar.showSnackbar("Sucess", "User updated successfully");

      }
    } catch (e) {
      logger.e(e);
    }
  }

  

  
}
