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
            'authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI1NjNmZDE0My05ZmVjLTRiYWEtYTU0NS1hZjViNzkxYmJiM2UiLCJ1SGFzaCI6IjU5ZTY0MjNkNTMyY2I1ODVkODBiOTM5NDgxZGM4MWIyNzQ1OTA5MjQ5YThhZWZmNzIxNTU0MTJlZTgwNTc5MTgiLCJwQWNjdCI6IjdjODY5M2M2LTk3NmUtNDMyNC05MTIzLTJjMWQ4MTE2MDVmOSIsImFjY3QiOiI3Yzg2OTNjNi05NzZlLTQzMjQtOTEyMy0yYzFkODExNjA1ZjkiLCJwcml2cyI6Wzg2ODY3OTYzMyw1MzY4MTYwOTYsMV0sInVzZXJuYW1lIjoicWF0ZWFtQHl0ZWwuY29tIiwic2NvcGUiOiJST0xFX0FDQ0VTU19UT0tFTiIsImlzcyI6Imh0dHBzOi8veXRlbC5jb20iLCJpYXQiOjE2NzEyNzA2NTMsImV4cCI6MTY3MTI3Nzg1M30.DLE9qLdg1i0TL3QnrcSd5D_238Miq3dRdUTkSwNIB1WLERhkAywbtjVj2xjlu4MbH7jTDfP0TdRwXirXmf6K4gOVbQZX8oMzK8XJckncVWYC1ft5UwLTgeQFbT6TZWQmgJgHquzzUca6yhrs2DQmtKteVY_whM1My5nlTHTZdprDCYmIytgE7An9VNhDoSfBu9NoDLrjJhopFqumwnc9tltaDm7bGc8rc7XP1g_IypO0SBfivPn5DOzfdKcgTfOt0_SkV5lfqSbJg3vw2LbtYk501HNjRARNk1Nj-xtmWzLj920JJh7oBLImbhdbK6dxrShec7K56HK_mFwgWZmxNw',
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