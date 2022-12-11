import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/model/search_contact_model.dart';

import '../../../services/api_services.dart';
import '../../../utils/extension.dart';

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