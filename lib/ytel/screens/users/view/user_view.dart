import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:ytel/ytel/screens/users/view/edit%20user.dart';

import 'create_user.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        appbar(context),
        body(),

      ],
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
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: ColorHelper.colors[6].withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: ColorHelper.colors[7]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Center(
                              child: Icon(
                                IconHelper.icons[6],
                                color: ColorHelper.colors[8],
                                size: 15,
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
                  "${StringHelper.titles[6]}",
                  style: TextStyle(fontSize: 24),
                ),
                Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: ColorHelper.colors[0]),
                              child: Center(
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(create_user());
                                    },
                                    child: Icon(
                                      IconHelper.icons[7],
                                      color: ColorHelper.colors[8],
                                      size: 20,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(width: 14,),
                InkWell(
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
                            color: ColorHelper.colors[0]),
                        child: Center(
                            child: Icon(
                              IconHelper.icons[8],
                              color: ColorHelper.colors[8],
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14,),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: ColorHelper.colors[0]),
                        child: Center(
                            child: Icon(
                              IconHelper.icons[9],
                              color: ColorHelper.colors[8],
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    ],
  );
}

Widget body(){
  return Expanded(child: Center(
    child: FutureBuilder(
      future: user_view_controller.data(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: ColorHelper.colors[6],strokeWidth: 1,),
          );
        }else if(snapshot.hasError){
          return Center(
            child: CircularProgressIndicator(color: ColorHelper.colors[6],strokeWidth: 1,),
          );
        }else{
          print("Got Data");
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount : snapshot.data.length,
                    itemBuilder: (context , int index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(),

                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Icon(IconHelper.icons[10],color: ColorHelper.colors[7],),
                              SizedBox(width: 15,),
                              Text(snapshot.data![index.toInt()]["firstName"].toString() + snapshot.data![index.toInt()]["lastName"].toString()),
                              Expanded(child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: (){
                                      user_view_controller.first_name.text = "${snapshot.data![index.toInt()]["firstName"]}";
                                      user_view_controller.last_name.text = "${snapshot.data![index.toInt()]["lastName"]}";
                                      user_view_controller.email.text = "${snapshot.data![index.toInt()]["emailAddress"]}";
                                      user_view_controller.web_phone.text = "${snapshot.data![index.toInt()]["webrtcNumber"]}";
                                      user_view_controller.phone_number.text = "${snapshot.data![index.toInt()]["phone"]}";

                                      Get.to(() => edit_user());
                                    },
                                    child: Icon(IconHelper.icons[11],color: ColorHelper.colors[7],)),
                              )),
                              SizedBox(width: 5,),
                              Icon(IconHelper.icons[12],color: ColorHelper.colors[2],)
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        }
      },
    ),
  ));
}
