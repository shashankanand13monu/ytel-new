import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/widget/common_snackbar.dart';
import 'package:ytel/ytel/services/interceptors.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class EditContact extends StatefulWidget {
  dynamic snapshot;

  EditContact({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<EditContact> createState() =>
      _EditContactState(snapshot);
}

class _EditContactState extends State<EditContact> {
  dynamic snapshot;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  //create a list of labels for a form
  List<String> labels = [
    "Phone No",
    "First Name",
    "Last Name",
    "Email",
    "Address",
    "City",
    "State",
    "Pincode",
    "Country",
  ];

  var apiList;
  bool _isLoading = false;

  String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

  _EditContactState(this.snapshot);
  @override
  Widget build(BuildContext context) {
    controllers[0].text = snapshot['extData']['phonenumber1'];
    controllers[1].text = snapshot['extData']['firstname']==null?"":snapshot['extData']['firstname'];
    controllers[2].text = snapshot['extData']['lastname']==null?"":snapshot['extData']['lastname'];
    controllers[3].text = snapshot['extData']['email1']==null?"":snapshot['extData']['email1'];
    controllers[4].text = snapshot['extData']['address1']==null?"":snapshot['extData']['address1'];
    controllers[5].text = snapshot['extData']['city1']==null?"":snapshot['extData']['city1'];
    controllers[6].text = snapshot['extData']['state1']==null?"":snapshot['extData']['state1'];
    controllers[7].text = snapshot['extData']['zip1']==null?"":snapshot['extData']['zip1'];
    controllers[8].text = snapshot['extData']['country1']==null?"":snapshot['extData']['country1'];


    //Display 3 screen defaultTabController
    Color color = ColorHelper.colors[9];
    print(snapshot);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryTextColor,
        title: Text(
          "Edit Contact",
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
            SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controllers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(labels[index],
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
                            controller: controllers[index],
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
                      );
                    },
                  ),
                ),
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
             
              putApi(
                controllers[0].text,
                controllers[1].text,
                controllers[2].text,
                controllers[3].text,
                controllers[4].text,
                controllers[5].text,
                controllers[6].text,
                controllers[7].text,
                controllers[8].text,
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
