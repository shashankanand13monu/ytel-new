import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';

import '../../../../helper/constants/colors.dart';

class country_code_picker extends StatefulWidget {
  const country_code_picker({Key? key}) : super(key: key);

  @override
  State<country_code_picker> createState() => _country_code_pickerState();
}

class _country_code_pickerState extends State<country_code_picker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "Code",
                style: TextStyle(fontSize: 14, color: ColorHelper.colors[9]),
              ),
            )),
        InkWell(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              // optional. Shows phone code before the country name.
              onSelect: (Country country) {
                print('Select country: ${country.displayName}');
                setState(() {
                  user_view_controller.country_code = "+${country.phoneCode}";
                });
              },
            );
          },
          child: Container(
            height: 80,
            width: 60,
            decoration: BoxDecoration(
                // color: ColorHelper.colors[6].withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: ColorHelper.colors[4])),
            child: Center(
              child: Text("${user_view_controller.country_code}"),
            ),
          ),
        ),
      ],
    );
  }
}
