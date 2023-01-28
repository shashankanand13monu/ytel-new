import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/auth/view/auth_page.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

class DioErrorUtils {

  static String handleError(DioError error) {

    String errorDescription = "";

    switch (error.type) {

      case DioErrorType.connectTimeout:
        errorDescription = "Connect Request Timeout" ;
        break;

      case DioErrorType.sendTimeout:
        errorDescription = "Send Timeout. Please try after sometime.";
        break;

      case DioErrorType.receiveTimeout:
        errorDescription = "Receive Timeout. Please try after sometime.";
        break;

      case DioErrorType.response:
        if (error.response!.statusCode == 12039 || error.response!.statusCode == 12040) {
          errorDescription = "Connection to server failed due to internet connection.";
        } else if (401 == error.response!.statusCode) {
          errorDescription = "Looks like you are unauthorized for this operation. Please login again.";
          StorageUtil.clearData();
          Get.offAll(const AuthPage());
        } else if (401 < error.response!.statusCode! && error.response!.statusCode! <= 417) {
          errorDescription = "Something when wrong. Please try again.";
        } else if (500 <= error.response!.statusCode! && error.response!.statusCode! <= 505) {
          errorDescription = "Request can't be handled for now. Please try after sometime.";
        } else {
          errorDescription = "Server error. Please try after sometime.";
        }
        break;

      case DioErrorType.cancel:
        errorDescription = "Request to server was cancelled";
        break;

      case DioErrorType.other:
        if (error.error is SocketException) {
          errorDescription = "Connection to server failed due to internet connection.";
        }

        if (error.response != null) {

          if (401 == error.response!.statusCode) {
            errorDescription = "Looks like you are unauthorized for this operation. Please login again.";
            StorageUtil.clearData();
            Get.offAll(const AuthPage());
          } else if (401 < error.response!.statusCode! && error.response!.statusCode! <= 417) {
            errorDescription = "Something when wrong. Please try again.";
          } else if (500 <= error.response!.statusCode! && error.response!.statusCode! <= 505) {
            errorDescription = "Request can't be handled for now. Please try after sometime.";
          }
        }
        break;
    }

    return errorDescription;
  }
}