//A Snackbar that can be used to display a message to the user.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_snackbar.dart';

class CommonSnackBar {
  /// Show a snackbar with a message which accept 2 string as parameter
  /// [message] is the message to be shown
  /// [title] is the title of the snackbar
  
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: title=="Error"?Colors.red:Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}