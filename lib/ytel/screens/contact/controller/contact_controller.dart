import 'dart:convert';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/model/search_contact_model.dart';
import 'package:http/http.dart' as http;
import '../../../helper/constants/strings.dart';
import '../../../services/api_services.dart';
import '../../../utils/extension.dart';
import '../../../utils/storage_utils.dart';

class ContactController extends GetxController {

  Logger logger = Logger();

  SearchContactModel? searchContactModel;

  // Get Contact
  void getContactData() async {
    try {
      d.Response response = await ApiServices().getContactData();
      if(response.statusCode == 200 || response.statusCode == 201) {
        logger.d("Contact Data: ${response.data}");
      } else if(response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("Contact Controller: $e");
    }
  }

  static data() async {
    String url = '${StringHelper.BASE_URL}api/v4/contact/';
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

  static contactImportStatus() async {
    String url = '${StringHelper.BASE_URL}api/v4/fileupload/202301/';
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

  static attributes() async {
    String accId = StorageUtil.getString(StringHelper.ACCOUNT_ID);
    String url = '${StringHelper.BASE_URL}ams/v2/accounts/config/$accId';
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

  // Search Contact
  searchContactData(Map<String, dynamic> body) async {
    try {
      d.Response response = await ApiServices().searchContactData(body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        searchContactModel = SearchContactModel.fromJson(response.data);
        update();
      } else if(response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("Contact Controller: $e");
    }
  }
}