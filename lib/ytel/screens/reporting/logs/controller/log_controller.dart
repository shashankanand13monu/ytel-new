import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../model/log_model.dart';
import '../../../../services/api_services.dart';
import '../../../../utils/extension.dart';

class LogController extends GetxController {
  Logger logger = Logger();
  SearchLogModel? searchLogModel;

  getSettingData() async {
    try {
      d.Response response = await ApiServices().logSearch();
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.d("Search Data: ${response.data}");
        searchLogModel = SearchLogModel.fromJson(response.data);
      } else if (response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("Search Controller: $e");
    }
  }
}
