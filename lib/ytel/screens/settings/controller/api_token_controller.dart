import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class api_token_controller extends GetxController {
  static data() async {
    String accId = StorageUtil.getString(StringHelper.ACCOUNT_ID);

    String url = '${StringHelper.BASE_URL}ams/v2/keys/account/$accId';
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    try {
      print("Inside Try");
      var result = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            'authority': 'api.ytel.com',
            'accept': 'application/json, text/plain, */*',
            'accept-language': 'en-US,en;q=0.9',
            'authorization': 'Bearer $accessToken',
          });

      if (result.statusCode == 200) {
        print("OK");
        var data = json.decode(result.body);
        print(data);
        return data;
      } else {
        print("Something went Wrong");
      }
    } catch (e) {
      print(e);
    }
  }
  
}