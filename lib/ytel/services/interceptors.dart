import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/auth/view/auth_page.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

var logger = Logger();

Dio dio = Dio(
  BaseOptions(
    baseUrl: StringHelper.BASE_URL,
    contentType: "application/json",
    headers: {
      HttpHeaders.acceptHeader: "application/json",
    }
  ),
);

Interceptor interceptor = InterceptorsWrapper(
  onError: (DioError e, handler) {

    logger.e("Interceptor Dio Error Code: ${e.response!.statusCode}");

    if(e.response!.statusCode == 401 || e.response!.statusCode == 403) {
      String refreshToken = StorageUtil.getString(StringHelper.REFRESH_TOKEN);

      logger.d("Interceptor Refresh Token: $refreshToken");

      StorageUtil.clearData();
      Get.offAll(const AuthPage());
    }
  }
);

Dio globalDio() {

  Dio dios = Dio();

  dios.interceptors.add(interceptor);

  return dios;
}

