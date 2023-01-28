import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/widget/custom_widget.dart';
import 'package:ytel/ytel/screens/contact/controller/contact_controller.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/strings.dart';
import '../../../utils/extension.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final ContactController contactController = Get.put(ContactController());

  int fromPage = 0;
  int toPage = 100;

  List<bool> listOfCheckBox = [];

  getSearchContact(Map<String, dynamic> body) async {

    bool isInternetOn = await check();

    if(isInternetOn) {
      await contactController.searchContactData(body);
      if(contactController.searchContactModel != null) {
        listOfCheckBox = List.generate(contactController.searchContactModel!.payload!.length, (index) => false);
      } else {
        snackBar(StringHelper.NO_INTERNET, ColorHelper.errorSnackBarColor);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getSearchContact({
      "from": fromPage,
      "size": toPage,
      "statements": []
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      builder: (_) => Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _bottomBar(),
        body: contactController.searchContactModel != null ? _body() : const SizedBox(),
      ),
    );
  }

  AppBar _appBar() => AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Get.back();
      },
      color: ColorHelper.primaryTextColor,
    ),
    title: const Text(
      "Contacts"
    ),
  );

  Widget _bottomBar() => Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
    padding: const EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 1)
        )
      ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // More
        CustomPageButton(
          onTap: () {
            if(fromPage > 0) {
              getSearchContact({
                "from": 0,
                "size": 100,
                "statements": []
              });
            }
            setState(() {
              fromPage = 0;
              toPage = 100;
            });
          },
          icon: FontAwesomeIcons.anglesLeft,
        ),

        // Single
        CustomPageButton(
          onTap: () {
            setState(() {
              if(fromPage <= 100) {
                fromPage = 0;
              } else {
                fromPage = fromPage - 100;
              }
              toPage = toPage - 100;
            });
            getSearchContact({
              "from": fromPage,
              "size": toPage,
              "statements": []
            });
          },
          icon: FontAwesomeIcons.angleLeft,
        ),

        Text(
          "$fromPage - $toPage",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),

        // Single
        CustomPageButton(
          onTap: () {
            setState(() {
              if(toPage <= contactController.searchContactModel!.payload!.length) {
                toPage = toPage + 100;
              } else {
                toPage = contactController.searchContactModel!.payload!.length;
              }
              fromPage = fromPage + 100;
            });
            getSearchContact({
              "from": fromPage,
              "size": toPage,
              "statements": []
            });
          },
          icon: FontAwesomeIcons.angleRight,
        ),

        //More
        CustomPageButton(
          onTap: () {
           if(toPage < contactController.searchContactModel!.count!) {
             setState(() {
               fromPage = contactController.searchContactModel!.count! - 100;
               toPage = contactController.searchContactModel!.count!;
             });
             getSearchContact({
               "from": fromPage,
               "size": toPage,
               "statements": []
             });
           }
          },
          icon: FontAwesomeIcons.anglesRight,
        ),
      ],
    ),
  );

  Widget _body() => ListView.builder(
    itemCount: contactController.searchContactModel!.payload!.length,
    itemBuilder: (context, index) => ExpansionTile(
      leading: SizedBox(
        height: 20,
        width: 20,
        child: Checkbox(
          value: listOfCheckBox[index],
          onChanged: (val) {
            setState(() {
              listOfCheckBox[index] = val!;
            });
          },
        ),
      ),
      tilePadding: const EdgeInsets.only(left: 15, right: 0),
      title: Text(
        contactController.searchContactModel!.payload![index].extData!.phonenumber1!.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      children: [
        // Name
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            children: const [
              Text(
                "Name : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Unkown",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // First Name
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            children: const [
              Text(
                "First Name : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Unkown",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Created Date
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            children: [
              const Text(
                "Created Date : ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                contactController.searchContactModel!.payload![index].created!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
