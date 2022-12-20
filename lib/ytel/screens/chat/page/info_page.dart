import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/screens/chat/page/edit_info.dart';

class InfoPage extends StatelessWidget {
  AsyncSnapshot<dynamic> snapshot;
  int index;
  InfoPage({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Detail Info',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Heading named "Contact Detalis"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  snapshot.data!["payload"][index.toInt()]["contact"]["extData"]
                              ["firstname"]
                          .toString() +
                      " " +
                      snapshot.data!["payload"][index.toInt()]["contact"]
                              ["extData"]["lastname"]
                          .toString(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                //Icon Named "Copy ID":
                IconButton(
                  icon: Icon(
                    Icons.copy_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            //A Row with heading "Contact Details" and "Edit" Text in Blue color
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(edit_info(),transition: Transition.leftToRightWithFade);
                  },
                  child: Text(
                    "Edit ",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            SizedBox(
              height: 20,
            ),

            //Phone icon with phone number
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  snapshot.data!["payload"][index.toInt()]["contact"]["extData"]
                          ["phonenumber1"]
                      .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            // "+ Add Contact Number" Text in Red Color
            Row(
              children: [
                Text(
                  "+ Add Contact to DNC",
                  style: TextStyle(
                    color: Color.fromARGB(255, 140, 32, 24),
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            //"Email" icon with email
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  snapshot.data!["payload"][index.toInt()]["contact"]["extData"]
                          ["email1"]
                      .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  snapshot.data!["payload"][index.toInt()]["contact"]["extData"]
                          ["address1"]
                      .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                // Notes Text
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 121, 121),
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(
              height: 7,
            ),
            //Big Box to write the text
            Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: snapshot.data!["payload"][index.toInt()]["contact"]
                          ["extData"]["notes"]
                      .toString(),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Custom Attributes text
            Row(
              children: [
                Text(
                  "Custom Attributes",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 121, 121),
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            // 3 Text with Bullet Points
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "brocoli" +
                      " : " +
                      snapshot.data!["payload"][index.toInt()]["contact"]
                              ["extData"]["brocoli"]
                          .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "hello" +
                      " : " +
                      snapshot.data!["payload"][index.toInt()]["contact"]
                              ["extData"]["hello"]
                          .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "testingwithrance2" +
                      " : " +
                      snapshot.data!["payload"][index.toInt()]["contact"]
                              ["extData"]["testingwithrance2"]
                          .toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
