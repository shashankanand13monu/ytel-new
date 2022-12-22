import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/strings.dart';
import '../../../utils/extension.dart';
import '../../../utils/storage_utils.dart';

class start_convo_controller extends GetxController {
  
  static data() async{
    String url = '${StringHelper.BASE_URL}api/v4/inbox/name';
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

  static upload_data(String to, String from,String text) async{
    String url = '${StringHelper.BASE_URL}api/v4/conversation';
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
            

          },
        body: {
          {
          "text": text,
          "to": to,
          "source":{"sourceId":"ytelapi"},
          "metadata":{"contactId":"a136e329-0ff6-4813-9319-c13068748414","publish":true},
          "from": from,
          "numberSetId":null
          }
        },
      ).then((value) => {
      print("Done !!!!!!!!!!!!!")
      });
    }catch(e){
      return snackBar(e.toString() , ColorHelper.errorSnackBarColor);

    }
  }
}

