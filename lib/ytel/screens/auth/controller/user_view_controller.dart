import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class user_view_controller extends GetxController {
  static final account_controller = new TextEditingController();
  static data() async{
    String url = '${StringHelper.BASE_URL}ams/v2/accounts/users/7c8693c6-976e-4324-9123-2c1d811605f9/';
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
}