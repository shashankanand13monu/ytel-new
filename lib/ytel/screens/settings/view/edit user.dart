// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:ytel/ytel/helper/constants/colors.dart';
// import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';

// import '../../../helper/constants/icons.dart';
// import '../../../helper/constants/strings.dart';
// import 'elements/check_box.dart';
// import 'elements/country_code_picker.dart';

// class edit_user extends StatelessWidget {
//   const edit_user({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         height: 1800,
//         child: Column(
//           children: [
//             appbar(context),
//             SizedBox(
//               height: 20,
//             ),
//             Text_Feild("First Name", "string", user_view_controller.first_name),
//             SizedBox(
//               height: 10,
//             ),
//             Text_Feild("Last Name", "string", user_view_controller.last_name),
//             SizedBox(
//               height: 10,
//             ),
//             Text_Feild("Email", "string", user_view_controller.email),
//             SizedBox(height: 10,),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18),
//               child: reset_password_button(),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text_Feild("Web Phone", "number", user_view_controller.web_phone),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 18,
//                 ),
//                 country_code_picker(),
//                 Expanded(
//                     child: Text_Feild("Phone Number", "number",
//                         user_view_controller.phone_number)),
//               ],
//             ),

//             Row(
//               children: [
//                 Expanded(child: subscription_type()),
//                 Expanded(child: Extensions())
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Inbox",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Contacts",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Workflows",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Numbers",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Webphone",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "UcasS",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Reporting",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Billing Admin",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Users & Accounts",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Assets",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18,right: 18,top: 10),
//               child: check_box(text: "Tracking",),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 40,left: 18,right: 18),
//               child: Row(
//                 children: [
//                   Cancel_button(),
//                   SizedBox(width: 10,),
//                   Expanded(child: save_button())
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget Text_Feild(hint_text, input_type, controller) {
//   return Padding(
//     padding: const EdgeInsets.all(18.0),
//     child: Column(
//       children: [
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 13),
//               child: Text(
//                 "${hint_text}",
//                 style: TextStyle(fontSize: 14, color: ColorHelper.colors[9]),
//               ),
//             )),
//         Container(
//           height: 80,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               // color: ColorHelper.colors[6].withOpacity(0.1),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               border: Border.all(color: ColorHelper.colors[4])
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 18),
//               child: TextFormField(
//                 controller: controller,
//                 keyboardType: input_type == "number"
//                     ? TextInputType.number
//                     : TextInputType.text,
//                 cursorColor: ColorHelper.colors[6],
//                 style: TextStyle(color: ColorHelper.colors[6]),
//                 decoration: InputDecoration.collapsed(
//                     hintText: "${hint_text}",
//                     hintStyle: TextStyle(color: ColorHelper.colors[9])),
//               ),
//             ),
//           ),
//         ),

//       ],
//     ),
//   );
// }


// Widget reset_password_button(){
//   return Container(
//     height: 60,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//       border: Border.all(color: ColorHelper.colors[6]),
//       color: ColorHelper.colors[2].withOpacity(0.26)
//     ),
//     child: Center(child: Text("Send Reset Password Request",style: TextStyle(letterSpacing: 1),),),
//   );
// }

// Widget subscription_type(){
//   return Padding(
//     padding: const EdgeInsets.all(18.0),
//     child: Column(
//       children: [
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 13),
//               child: Text(
//                 "Subscription Type",
//                 style: TextStyle(fontSize: 14, color: ColorHelper.colors[9]),
//               ),
//             )),
//         Container(
//           height: 80,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             // color: ColorHelper.colors[6].withOpacity(0.1),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               border: Border.all(color: ColorHelper.colors[4])
//           ),
//           child: Center(
//             child: CustomDropdown(
//               fillColor: Colors.transparent,
//               borderRadius: BorderRadius.zero,
//               hintText: 'Subscription Type',
//               items: const ['UcaaS webphone : Voice', 'UCaaS contact center : Customer Relationship', 'UCaaS unified webphone : Unified Communication'],
//               controller: user_view_controller.subscription_type,
//             ),
//           ),
//         ),

//       ],
//     ),
//   );
// }

// Widget Extensions(){
//   return Padding(
//     padding: const EdgeInsets.all(18.0),
//     child: Column(
//       children: [
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 13),
//               child: Text(
//                 "Extensions",
//                 style: TextStyle(fontSize: 14, color: ColorHelper.colors[9]),
//               ),
//             )),
//         Container(
//           height: 80,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             // color: ColorHelper.colors[6].withOpacity(0.1),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               border: Border.all(color: ColorHelper.colors[4])
//           ),
//           child: Center(
//             child: CustomDropdown(
//               fillColor: Colors.transparent,
//               borderRadius: BorderRadius.zero,
//               hintText: 'Extensions',
//               items: const ['UcaaS webphone : Voice', 'UCaaS contact center : Customer Relationship', 'UCaaS unified webphone : Unified Communication'],
//               controller: user_view_controller.subscription_type,
//             ),
//           ),
//         ),

//       ],
//     ),
//   );
// }

// Widget Cancel_button(){
//   return InkWell(
//     onTap: (){
//       Get.back();
//     },
//     child: Container(
//       height: 50,
//       width: 90,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         border: Border.all()
//       ),
//       child: Center(
//         child: Text("Decline"),
//       ),
//     ),
//   );
// }

// Widget save_button(){
//   return Container(
//     height: 60,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         color: ColorHelper.colors[0]
//     ),
//     child: Center(
//       child: Text("Save",style: TextStyle(color: ColorHelper.colors[8],fontSize: 19,letterSpacing: 1),),
//     ),
//   );
// }

// Widget appbar(context){
//   return Column(
//     children: [
//       SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(18),
//             child: Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(60)),
//                       color: ColorHelper.colors[6].withOpacity(0.2),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(3.0),
//                       child: Container(
//                         height: double.infinity,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(60)),
//                             color: ColorHelper.colors[7]),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 5),
//                           child: Center(
//                               child: InkWell(
//                                 onTap: (){

//                                 },
//                                 child: Icon(
//                                   IconHelper.icons[6],
//                                   color: ColorHelper.colors[8],
//                                   size: 15,
//                                 ),
//                               )),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(
//                   "${StringHelper.titles[8]}",
//                   style: TextStyle(fontSize: 24),
//                 ),

//               ],
//             ),
//           )),
//     ],
//   );
// }