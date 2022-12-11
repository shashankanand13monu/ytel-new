import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/screens/splash_screen/view/splash_screen.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageUtil.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ytel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleSpacing: 0,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: ColorHelper.primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          color: ColorHelper.scaffoldBGColor,
        ),
        scaffoldBackgroundColor: ColorHelper.scaffoldBGColor,
        fontFamily: GoogleFonts.lato().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

