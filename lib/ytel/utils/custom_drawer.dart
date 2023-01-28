// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/Number_Management/view/number_view.dart';
import 'package:ytel/ytel/screens/Under_Development/under_devlopment.dart';
import 'package:ytel/ytel/screens/accounts/account_screen.dart';
import 'package:ytel/ytel/screens/chat/chat_home_screen.dart';
import 'package:ytel/ytel/screens/contact/view/contact_view.dart';
import 'package:ytel/ytel/screens/dashboard/view/dashboard_page.dart';
import 'package:ytel/ytel/screens/users/view/user_view.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName =
        StorageUtil.getString(StringHelper.ACCOUNT_NAME);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorHelper.primaryTextColor,
              ),
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Ytel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            _commonTile("Dashboard", const DashboardPage(),
                "assets/images/monitor.png"),
            _commonTile("Inbox", ChatHomeScreen(),
                "assets/images/inbox.png"),
            _commonMethod(
                "assets/images/contact.png", "Contacts", [
              _commonListTile(
                  "Contacts", const ContactPage()),
              _commonListTile("Contact Import Status",
                  const UnderDevelopment()),
              _commonListTile(
                  "Attributes", const UnderDevelopment()),
            ]),
            _commonMethod("assets/images/project-plan.png",
                "Workflow", [
              _commonListTile(
                  "Workflows", const UnderDevelopment()),
              _commonListTile("Message Templates",
                  const UnderDevelopment()),
              _commonListTile(
                  "Webhooks", const UnderDevelopment()),
              _commonListTile(
                  "Enrollment", const UnderDevelopment()),
            ]),
            _commonMethod(
                "assets/images/hashtag.png", "Numbers", [
              _commonListTile(
                  "Purchase", const UnderDevelopment()),
              _commonListTile(
                  "Manage", const NumberScreen()),
              _commonListTile(
                  "Number Sets", const UnderDevelopment()),
            ]),
            _commonMethod("assets/images/call-center.png",
                "Reporting", [
              _commonListTile(
                  "Usage", const UnderDevelopment()),
              _commonListTile(
                  "Logs", const UnderDevelopment()),
              _commonListTile("Routing statistics",
                  const UnderDevelopment()),
              _commonListTile(
                  "Tracking", const UnderDevelopment()),
              _commonListTile(
                  "Workflow", const UnderDevelopment()),
              _commonListTile("Workflow failures",
                  const UnderDevelopment()),
              _commonListTile("Workflow paths",
                  const UnderDevelopment()),
            ]),
            _commonMethod(
                "assets/images/settings.png", "Settings", [
              _commonListTile(
                  "Billing", const UnderDevelopment()),
              _commonListTile(
                  "Accounts", const AccountScreen()),
              _commonListTile("Users", const UsersPage()),
              _commonListTile("Buissness Profiles",
                  const UnderDevelopment()),
              _commonListTile(
                  "Assets", const UnderDevelopment()),
              _commonListTile(
                  "API Tokens", const UnderDevelopment()),
              _commonListTile(
                  "Callbacks", const UnderDevelopment()),
              _commonListTile("CNAM Management",
                  const UnderDevelopment()),
              _commonListTile(
                  "Compliance", const UnderDevelopment()),
              _commonListTile(
                  "Audit", const UnderDevelopment()),
            ]),
            _commonTile(
                "Contact Center",
                const UnderDevelopment(),
                "assets/images/customer-care.png"),
            _commonTile("UCaaS", const UnderDevelopment(),
                "assets/images/telephone.png"),
            _commonTile(
                "Add Feature",
                const UnderDevelopment(),
                "assets/images/plus.png"),
            Divider(),
            _commonMethod(
                "assets/images/user_dp.png", userName, [
              _commonListTile(
                  "Profile", const UnderDevelopment()),
              _commonListTile(
                  "Logout", const UnderDevelopment()),
            ]),
            _commonMethod(
                "assets/images/information.png", "Help", [
              _commonListTile("Help Articles",
                  const UnderDevelopment()),
              _commonListTile("Product Updates",
                  const UnderDevelopment()),
              _commonListTile("System Status",
                  const UnderDevelopment()),
              _commonListTile("Training videos",
                  const UnderDevelopment()),
              _commonListTile(
                  "API", const UnderDevelopment()),
            ]),
            _drawerSearchBar(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _commonMethod(String imgPath, String name,
          List<Widget> listOfWidget) =>
      ExpansionTile(
          leading: Image.asset(imgPath,
              height: 32, color: Colors.blue),
          title: Text(name,
              style: const TextStyle(
                  color: ColorHelper.primaryTextColor,
                  fontSize: 17)),
          children: listOfWidget);

  Widget _commonListTile(String name, Widget navPage) =>
      ListTile(
        title: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: ColorHelper.primaryTextColor,
              fontSize: 15,
            ),
          ),
        ),
        onTap: () {
          Get.to(() => navPage);
        },
      );

  Widget _commonTile(
          String name, Widget navPage, String imgPath) =>
      ListTile(
        leading: Image.asset(
          imgPath,
          height: 32,
          color: Colors.blue,
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: ColorHelper.primaryTextColor,
            fontSize: 15,
          ),
        ),
        onTap: () {
          Get.to(() => navPage);
        },
      );

  Widget _drawerSearchBar() => Padding(
        padding: const EdgeInsets.only(
            left: 15, right: 15, top: 15),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 206, 228, 247),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: ColorHelper.primaryTextColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: ColorHelper.primaryTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // List<DrawerItems> drawerItemList = [
  //   DrawerItems(image, title, listOfWidget, () {})
  // ];
}

class DrawerItems {
  String image;
  String title;
  List<Widget>? listOfWidget;
  VoidCallback onTap;
  DrawerItems(this.image, this.title, this.listOfWidget,
      this.onTap);
}
