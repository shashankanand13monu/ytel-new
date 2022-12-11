import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/utils/dio_error_utils.dart';
import 'package:ytel/ytel/utils/extension.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

class DioClient {

  final Dio _dio = Dio();
  var logger = Logger();

  Map<String, dynamic> headers = {};

  DioClient() {

    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      error: true,
      requestBody: true,
      requestHeader: false,
      responseBody: false,
      responseHeader: false,
      maxWidth: 90,
    ));

  }

  void _interceptor() {
    String accessToken = StorageUtil.getString(StringHelper.ACCESS_TOKEN);

    headers["Content-Type"] = "application/json";
    if (accessToken.isNotEmpty) headers['Authorization'] = 'Bearer $accessToken';

    _dio.options.headers = headers;
    _dio.options.followRedirects = true;

  }

  Future getMethod(String url) async {

    EasyLoading.show(
      status: "Please wait..",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );

    _interceptor();

    try {
      Response response = await _dio.get(StringHelper.BASE_URL + url);
      if(response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.dismiss();
        if(response.data["status"].toString() == "403") {
          snackBar(response.data["message"], Colors.blue);
        }
        return response;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      logger.e("Dio Error : $e");
      DioErrorUtils.handleError(e);
      return e.response;
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      logger.e("Socket Error: $e");
      return 500;
    } catch (e) {
      EasyLoading.dismiss();
      logger.e("Catch Error: $e");
      return null;
    }
    EasyLoading.dismiss();
  }

  Future postMethod(String url, Map<String, dynamic> body) async {

    EasyLoading.show(
      status: "Please wait..",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );

    _interceptor();

    try {
      Response response = await _dio.post(
        StringHelper.BASE_URL + url,
        data: body,
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.dismiss();
        if(response.data["status"].toString() == "403") {
          snackBar(response.data["message"], Colors.blue);
        }
        return response;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      logger.e("Dio Error : $e");
      // DioErrorUtils.handleError(e);
      snackBar(e.response!.data["message"], ColorHelper.errorSnackBarColor);
      return e.response;
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      logger.e("Socket Error: $e");
      return 500;
    } catch (e) {
      EasyLoading.dismiss();
      logger.e("Catch Error: $e");
      return null;
    }
    EasyLoading.dismiss();
  }

  Future deleteMethod(String url) async {

    EasyLoading.show(
      status: "Please wait..",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );

    _interceptor();

    try {
      Response response = await _dio.delete(StringHelper.BASE_URL + url);
      if(response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.dismiss();
        if(response.data["status"].toString() == "403") {
          snackBar(response.data["message"], Colors.blue);
        }
        return response;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      logger.e("Dio Error : $e");
      DioErrorUtils.handleError(e);
      return e.response;
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      logger.e("Socket Error: $e");
      return 500;
    } catch (e) {
      EasyLoading.dismiss();
      logger.e("Catch Error: $e");
      return null;
    }
  }

  Future putMethod(String url, Map<String, dynamic> body) async {

    EasyLoading.show(
      status: "Please wait..",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );

    _interceptor();

    try {
      Response response = await _dio.put(
        StringHelper.BASE_URL + url,
        data: body,
      );
      if(response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.dismiss();
        if(response.data["status"].toString() == "403") {
          snackBar(response.data["message"], Colors.blue);
        }
        return response;
      }
    } on DioError catch (e) {
      EasyLoading.dismiss();
      logger.e("Dio Error : $e");
      DioErrorUtils.handleError(e);
      return e.response;
    } on SocketException catch (e) {
      EasyLoading.dismiss();
      logger.e("Socket Error: $e");
      return 500;
    } catch (e) {
      EasyLoading.dismiss();
      logger.e("Catch Error: $e");
      return null;
    }

    EasyLoading.dismiss();
  }

}