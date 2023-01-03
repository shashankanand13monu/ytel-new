import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/constants/strings.dart';
import '../../../utils/storage_utils.dart';
import '../../auth/view/auth_page.dart';

// Create a Dialog Box to show the Logout Message without "flat button"
class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //Make Rounded Corner
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Yes'),
          onPressed: () {
            //Clear share preference and navigate to Login screen 
            StorageUtil.putBool(StringHelper.IS_LOGIN, false);

            Get.offAll(() => const AuthPage());
           

          },
        ),
        ElevatedButton(
          child: Text('No'),
          onPressed: () {
           
            Get.back();
          },
        ),
      ],
    );
  }
}
