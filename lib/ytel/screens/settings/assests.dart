import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/auth/controller/assets_controller.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:ytel/ytel/screens/settings/view/edit%20user.dart';

class AssetPage extends StatelessWidget {
  const AssetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.colors[6],
          title: Text(
            "Asset",
            style: TextStyle(
              color: ColorHelper.colors[0],
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Inbound Voice"),
              Tab(text: "Inbound SMS"),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              IconHelper.icons[6],
              color: ColorHelper.colors[0],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(
          children: [
            _bod(),
            _bod(),
          ],
        ),
      ),
    );
  }
}

Widget _bod() {
  return Center(
    child: Text("Hello"),
  );
}

Widget body() {
  return Expanded(
      child: Center(
    child: FutureBuilder(
      future: assests_controller.data(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorHelper.colors[6],
              strokeWidth: 1,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorHelper.colors[6],
              strokeWidth: 1,
            ),
          );
        } else {
          print("Got Data");
          print(snapshot);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
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
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                IconHelper.icons[10],
                                color: ColorHelper.colors[7],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                snapshot.data['payload'][index]['name'] == null
                                    ? "NULL"
                                    : snapshot.data['payload'][index]['name'],
                                style: TextStyle(
                                    fontSize: 18, color: ColorHelper.colors[7]),
                              ),
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      IconHelper.icons[11],
                                      color: ColorHelper.colors[7],
                                    )),
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                IconHelper.icons[12],
                                color: ColorHelper.colors[2],
                              )
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
