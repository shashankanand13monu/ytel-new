import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/dashboard/view/dashboard_page.dart';
import 'package:ytel/ytel/services/api_services.dart';
import 'package:ytel/ytel/utils/extension.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';
import 'package:dio/dio.dart' as d;

class AuthController extends GetxController {

  Logger logger = Logger();

  // User Login
  void userLogin(Map<String, dynamic> body) async {
    try {
      d.Response response = await ApiServices().loginUserData(body);

      if(response.statusCode == 200 || response.statusCode == 201) {
        StorageUtil.putString(StringHelper.ACCESS_TOKEN, response.data["accessToken"]);
        StorageUtil.putBool(StringHelper.IS_LOGIN, true);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(response.data["accessToken"]);
        // StorageUtil.putString(StringHelper.ACCESS_TOKEN, decodedToken["acct"]);

        logger.d("Decode Token: $decodedToken");
        getAllPrivileges();
        getAccountConfig(decodedToken["acct"]);
        Get.offAll(() => const DashboardPage());
      } else if(response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("User Controller:");
    }
  }

  // Get All Privileges
  void getAllPrivileges() async {
    try {
      d.Response response = await ApiServices().getAllPrivileges();

      if(response.statusCode == 200 || response.statusCode == 201) {
        logger.d(response.data);
      } else if(response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("User Controller:");
    }
  }

  // Account Config
  void getAccountConfig(String accountId) async {
    try {
      d.Response response = await ApiServices().getAccountConfigData(accountId);

      if(response.statusCode == 200 || response.statusCode == 201) {
        logger.d(response.data);
      } else if(response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("User Controller:");
    }
  }


}