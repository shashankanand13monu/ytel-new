// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:ytel/ytel/screens/auth/controller/user_view_accounts_controller.dart';
// import 'package:ytel/ytel/screens/settings/newUsers/Model/user_model.dart';

// import '../../../helper/constants/colors.dart';
// import '../../../helper/constants/icons.dart';
// import '../view/edit user.dart';
// import '../../../services/api_controller.dart';

// class UsersPageNew extends StatefulWidget {
//   const UsersPageNew({super.key});

//   @override
//   State<UsersPageNew> createState() => _UsersPageNewState();
// }

// class _UsersPageNewState extends State<UsersPageNew> {
//   List<UserModel>? apiList;
//   @override
//   void initState() {
//     super.initState();
//     _getAPI();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users'),
//       ),
//       body: apiList == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           :  Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                     itemCount : apiList!.length,
//                     itemBuilder: (context , int index){
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: 50,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               // border: Border.all(),

//                           ),
//                           child: Row(
//                             children: [
//                               SizedBox(width: 5,),
//                               Icon(IconHelper.icons[10],color: ColorHelper.colors[7],),
//                               SizedBox(width: 15,),
//                               Text(apiList![index].firstName! + ' '+ apiList![index].lastName!),
//                               Expanded(child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: InkWell(
//                                     onTap: (){
//                                       user_view_accounts_controller.first_name.text = apiList![index].firstName!;
//                                       user_view_accounts_controller.first_name.text = apiList![index].firstName!;
//                                       user_view_accounts_controller.last_name.text = apiList![index].lastName!;
//                                       user_view_accounts_controller.email.text = apiList![index].emailAddress!=null?apiList![index].emailAddress!:'';
//                                       user_view_accounts_controller.web_phone.text = apiList![index].webrtcNumber!=null?apiList![index].webrtcNumber!:'';
//                                       user_view_accounts_controller.phone_number.text = apiList![index].phone!;

//                                       Get.to(() => edit_user());
//                                     },
//                                     child: Icon(IconHelper.icons[11],color: ColorHelper.colors[7],)),
//                               )),
//                               SizedBox(width: 5,),
//                               Icon(IconHelper.icons[12],color: ColorHelper.colors[2],)
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               )
//             ],
//           ),
//     );
//   }

//   void _getAPI() async {
//     var response = await BaseUser()
//         .get(
//             'https://api.ytel.com/ams/v2/accounts/users/7c8693c6-976e-4324-9123-2c1d811605f9/')
//         .catchError(
//       (error) {
//         print(error);
//       },
//     );

//     print(response);
//     var users = userModelFromJson(response);
//     setState(() {
//       apiList = users;
//     });
//   }
// }
