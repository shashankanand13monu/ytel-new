import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';

class chat_view_controller extends GetxController {
 static data() async{
    String url = '${StringHelper.BASE_URL}api/v4/inbox/?inbox=7c8693c6-976e-4324-9123-2c1d811605f9';
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
}