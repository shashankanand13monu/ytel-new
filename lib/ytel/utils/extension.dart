

// Check Internet connection
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

snackBar(String msg, Color color) {
  return Get.snackbar(msg, "",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    colorText: Colors.white,
    messageText: const Text(""),
    titleText: Text(
      msg,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 15,
    isDismissible: true,
  );
}
