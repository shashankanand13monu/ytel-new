import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/dashboard/view/dashboard_page.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';
import '../../auth/view/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void startTimer() async {
    Timer(const Duration(seconds: 3), () {
      navigateUser();
    });
  }

  void navigateUser() async {

    bool isLogin = StorageUtil.getBool(StringHelper.IS_LOGIN);

    if (isLogin) {
      Get.offAll(() => const DashboardPage());
    } else {
      Get.offAll(() => const AuthPage());
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Ytel",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
