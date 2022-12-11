import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/helper/widget/custom_widget.dart';
import 'package:ytel/ytel/screens/auth/controller/auth_controller.dart';

import '../../../utils/extension.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final AuthController authController = Get.put(AuthController());

  TextEditingController emailConn = TextEditingController(text: "qateam@ytel.com");
  TextEditingController passwordConn = TextEditingController(text: "dhuxHJrz5D4nNnFmE468EzhN3yUKGL7euiDH9UCK");

  bool isShowPass = false;
  bool isPolicy = true;

  void signIn() async {
    check().then((connection) {
      if (connection) {
        authController.userLogin({
          "grantType": "resource_owner_credentials",
          "username": emailConn.text.trim(),
          "password": passwordConn.text,
          "pincode": ""
        });
      } else {
        snackBar(StringHelper.NO_INTERNET, ColorHelper.errorSnackBarColor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loginText(),

            // Email
            const SizedBox(height: 40),
            _emailWidget(),

            // Password
            const SizedBox(height: 20),
            _passwordWidget(),

            // Forgot password
            const SizedBox(height: 10),
            _forgotPassWidget(),

            // Sign In
            const SizedBox(height: 40),
            _loginButton(),

            // Policy
            const SizedBox(height: 40),
            _policyWidget(),
          ],
        ),
      ),
    );
  }

  Widget _loginText() => const Text(
    "Login",
    style: TextStyle(
      color: ColorHelper.primaryTextColor,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _emailWidget() => CustomTextField(
    readOnly: false,
    fieldController: emailConn,
    height: 40,
    maxLines: 1,
    color: Colors.white,
    hintName: "Email",
    prefixIcon: const Icon(
      Icons.person,
      color: ColorHelper.primaryTextColor,
    ),
  );

  Widget _passwordWidget() => CustomTextField(
    readOnly: false,
    fieldController: passwordConn,
    height: 40,
    maxLines: 1,
    color: Colors.white,
    hintName: "Password",
    showPassword: isShowPass,
    prefixIcon: const Icon(
      Icons.password_rounded,
      color: ColorHelper.primaryTextColor,
    ),
    suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          isShowPass = !isShowPass;
        });
      },
      icon: Icon(
        isShowPass ? Icons.visibility : Icons.visibility_off,
        color: ColorHelper.primaryTextColor,
      ),
    ),
  );

  Widget _forgotPassWidget() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
        onTap: () {
          // TODO
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: const Text(
          "Forgot password?",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
          ),
        ),
      ),
    ],
  );

  Widget _policyWidget() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.black54,
              ),
              child: Checkbox(
                value: isPolicy,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                activeColor: Colors.blue,
                splashRadius: 0,
                onChanged: (val) {
                  setState(() {
                    isPolicy = val!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(width: 3),
          const Text(
            "By using our services, agree to the",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
      const SizedBox(width: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(width: 27),
          InkWell(
            onTap: () {
              launchUrl(Uri.tryParse("https://mygridclub.com/terms/")!);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Text(
              "Ytel End User Licence Agreement",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _loginButton() => CustomButton(
    name: "Sign in",
    height: 45,
    width: MediaQuery.of(context).size.width,
    color: ColorHelper.primaryTextColor,
    onTap: () {
      if(emailConn.text.isNotEmpty && emailConn.text.contains("@") && emailConn.text.contains(".") && passwordConn.text.isNotEmpty && passwordConn.text.length >= 8) {
        signIn();
      } else {
        snackBar(StringHelper.INVALID_DATA, ColorHelper.invalidDataSnackBarColor);
      }
    },
  );
}
