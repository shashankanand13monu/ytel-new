import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';
import '../../../helper/constants/strings.dart';
import 'elements/check_box.dart';
import 'elements/country_code_picker.dart';

class create_user extends StatelessWidget {
  const create_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1500,
        child: Column(
          children: [
            appbar(context),
            Text_Feild("First Name", "string", user_view_controller.first_name_create),
            Text_Feild("Last Name", "string", user_view_controller.last_name_create),
            Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                country_code_picker(),
                Expanded(
                    child: Text_Feild("Phone Number", "number",
                        user_view_controller.phone_number_create)),
              ],
            ),
            Text_Feild("Password", "string", user_view_controller.password),
            Text_Feild("Confirm Password", "string", user_view_controller.confirm_password),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Inbox",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Contacts",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Workflows",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Numbers",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Webphone",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "UcasS",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Reporting",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Billing Admin",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Users & Accounts",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Assets",),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
              child: check_box(text: "Tracking",),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 18,right: 18),
              child: Row(
                children: [
                  Cancel_button(),
                  SizedBox(width: 10,),
                  Expanded(child: save_button())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget appbar(context){
  return Column(
    children: [
      SafeArea(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      color: ColorHelper.colors[6].withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: ColorHelper.colors[7]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Center(
                              child: InkWell(
                                onTap: (){

                                },
                                child: Icon(
                                  IconHelper.icons[6],
                                  color: ColorHelper.colors[8],
                                  size: 15,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "${StringHelper.titles[7]}",
                  style: TextStyle(fontSize: 24),
                ),

              ],
            ),
          )),
    ],
  );
}

Widget Text_Feild(hint_text, input_type, controller) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                "${hint_text}",
                style: TextStyle(fontSize: 14, color: ColorHelper.colors[9]),
              ),
            )),
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: ColorHelper.colors[6].withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: ColorHelper.colors[4])
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: TextFormField(
                controller: controller,
                keyboardType: input_type == "number"
                    ? TextInputType.number
                    : TextInputType.text,
                cursorColor: ColorHelper.colors[6],
                style: TextStyle(color: ColorHelper.colors[6]),
                decoration: InputDecoration.collapsed(
                    hintText: "${hint_text}",
                    hintStyle: TextStyle(color: ColorHelper.colors[9])),
              ),
            ),
          ),
        ),

      ],
    ),
  );
}


Widget Cancel_button(){
  return InkWell(
    onTap: (){
      Get.back();
    },
    child: Container(
      height: 50,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all()
      ),
      child: Center(
        child: Text("Cancel"),
      ),
    ),
  );
}

Widget save_button(){
  return Container(
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ColorHelper.colors[0]
    ),
    child: Center(
      child: Text("Create",style: TextStyle(color: ColorHelper.colors[8],fontSize: 19,letterSpacing: 1),),
    ),
  );
}

