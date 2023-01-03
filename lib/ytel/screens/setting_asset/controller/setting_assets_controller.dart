import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../model/setting_assets_model.dart';
import '../../../services/api_services.dart';
import '../../../utils/extension.dart';

class Setting_Assets_Controller extends GetxController {
  Logger logger = Logger();

  SettingAssetsModel? settingAssetsModel;

  getSettingData() async {
    try {
      d.Response response = await ApiServices().getSettingAssetData();
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.d("Setting Data: ${response.data}");
        settingAssetsModel = SettingAssetsModel.fromJson(response.data);
      } else if (response.statusCode == 403) {
        snackBar(response.data["message"], Colors.blue);
      } else {
        snackBar("Please try again later", Colors.blue);
      }
    } catch (e) {
      logger.e("Setting Controller: $e");
    }
  }
}
