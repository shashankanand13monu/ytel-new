import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/strings.dart';
import '../../../utils/extension.dart';
import '../../../utils/storage_utils.dart';
import 'package:http/http.dart' as http;

class user_view_accounts_controller{
  static final account_controller = new TextEditingController();
  static data() async{
    String url = '${StringHelper.BASE_URL}ams/v2/accounts/7c8693c6-976e-4324-9123-2c1d811605f9/';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      print("Inside Try");
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'authority' : 'api.ytel.com',
            'accept' : 'application/json, text/plain, */*',
            'accept-language' : 'en-US,en;q=0.9',
            'authorization' : 'Bearer $accessToken',
            'origin' : 'https://app.ytel.com',
            'referer' : 'https://app.ytel.com/',
            'sec-ch-ua' : 'Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108',
            'sec-ch-ua-mobile' : '?0',
            'sec-ch-ua-platform' : 'Windows',
            'sec-fetch-dest' : 'empty',
            'sec-fetch-mode' : 'cors',
            'sec-fetch-site' : 'same-site',
            'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'

          });

      if (result.statusCode == 200) {
        print("OK");
        var data = json.decode(result.body);
        print(data);
        return data;
      }else{
        print("Something went Wrong");
      }
    }catch(e){
      print(e);
    }
  }

  bool country_code_selected = false;
  static var country_code = "+91";
  static TextEditingController first_name = TextEditingController();
  static TextEditingController last_name = TextEditingController();
  static TextEditingController web_phone = TextEditingController();
  static TextEditingController phone_number = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController subscription_type = TextEditingController();

  static bool inbox = false;
  static bool reporting = false;
  static bool contacts = false;
  static bool billing_admin = false;
  static bool workflow = false;
  static bool users_account = false;
  static bool number = false;
  static bool assets = false;
  static bool webphone = false;
  static bool tracking = false;
  static bool ucaas = false;


  //////////////////////////////// CREATE USER CONTROLLER ///////////////////////////////////////

  static TextEditingController first_name_create = TextEditingController();
  static TextEditingController last_name_create = TextEditingController();
  static TextEditingController phone_number_create = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController confirm_password = TextEditingController();
  static TextEditingController email_create = TextEditingController();


  static validate(){
    if(first_name_create.text == ""){
      return snackBar("Please Enter First Name" , ColorHelper.errorSnackBarColor);
    }else{
      if(last_name_create.text == ""){
        return snackBar("Please Enter Last Name" , ColorHelper.errorSnackBarColor);
      }else{
        if(password.text == ""){
          return snackBar("Please Enter Password Name" , ColorHelper.errorSnackBarColor);
        }else{
          if(confirm_password.text == ""){
            return snackBar("Please Enter Confirm Password Name" , ColorHelper.errorSnackBarColor);
          }else{
            if(phone_number_create.text == ""){
              return snackBar("Please Enter Phone Number" , ColorHelper.errorSnackBarColor);
            }else{
              print("Validate");
              return "Validate";
            }
          }
        }
      }
    }
  }

  static upload_data(){
    String url = '${StringHelper.BASE_URL}ams/v2/users';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);
    try{
      print("Inside Try");
      var upload = http.post(
        Uri.parse(url),
        headers: {
          'authority' : 'api.ytel.com',
          'accept' : 'application/json, text/plain, */*',
          'accept-language' : 'en-US,en;q=0.9',
          'authorization' : 'Bearer $accessToken',
          'origin' : 'https://app.ytel.com',
          'referer' : 'https://app.ytel.com/',
          'sec-ch-ua' : 'Not?A_Brand";v="8", "Chromium";v="108", "Google Chrome";v="108',
          'sec-ch-ua-mobile' : '?0',
          'sec-ch-ua-platform' : 'Windows',
          'sec-fetch-dest' : 'empty',
          'sec-fetch-mode' : 'cors',
          'sec-fetch-site' : 'same-site',
          'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36'

        },
        body: {
          "belongAcctId" : "7c8693c6-976e-4324-9123-2c1d811605f9",
          "clientId" : "null",
          "firstName" : "${first_name_create.text}",
          "lastName" : "${last_name_create.text}",
          "password" : "${password.text}",
          "phone" : "${country_code + phone_number_create.text}",
          "roles" : "gi-agent",
          "status" : "active",
          "webrtcNumber" : "",
          "username" : "${email_create.text}",
          "ucaasExtension" : ""
        },
      ).then((value) => {
        print("Done !!!!!!!!!!!!!")
      });
    }catch(e){
      return "$e";
    }
  }
}