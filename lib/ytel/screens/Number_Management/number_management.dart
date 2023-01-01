import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ytel/ytel/screens/Number_Management/view/edit_number.dart';
import 'package:ytel/ytel/screens/auth/controller/number_list_controller.dart';
import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:csv/csv.dart';

import '../../helper/constants/colors.dart';
import '../../helper/constants/icons.dart';

class NumberManagement extends StatefulWidget {
  const NumberManagement({super.key});

  @override
  State<NumberManagement> createState() => _NumberManagementState();
}
AsyncSnapshot<dynamic> snapshots = AsyncSnapshot<dynamic>.nothing();

class _NumberManagementState extends State<NumberManagement> {
  TextEditingController searchController = TextEditingController();
  bool search_pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          if (search_pressed) _searchNo(),
          SizedBox(height: 10),
          body(),
        ],
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: ColorHelper.primaryTextColor,
      title: Text('Numbers', style: TextStyle(color: Colors.white)),
      //Search icon in the end of appbar
      actions: [
        IconButton(
          onPressed: () async {
            _downloadCSV();
          },
          icon: Icon(Icons.download),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              search_pressed = !search_pressed;
            });
          },
          icon: Icon(Icons.search),
        ),
        //Download icon
      ],
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }

  _searchNo() {
    //return a container to input numbers
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: 50,
      width: 300,
      //rounded corners
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          
          hintText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  

  

  _downloadCSV() async {
    //download csv file of snapshots.data

    //convert in csv
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("accountSid");
    row.add("phoneSid");
    row.add("phoneNumber");
    row.add("voiceUrl");
    row.add("voiceMethod");
    row.add("voiceFallbackUrl");
    row.add("voiceFallbackMethod");
    row.add("renewalDate");
    row.add("purchaseDate");
    row.add("region");
    row.add("timezone");
    row.add("smsUrl");
    row.add("smsMethod");
    row.add("smsFallbackUrl");
    row.add("smsFallbackMethod");
    row.add("heartbeatUrl");
    row.add("heartbeatMethod");
    row.add("hangupCallbackUrl");
    row.add("hangupCallbackMethod");
    rows.add(row);

    for (Map i in snapshots.data['payload']) {
      row = [];
      row.add(i['accountSid']);
      row.add(i['phoneSid']);
      row.add(i['phoneNumber']);
      row.add(i['voiceUrl']);
      row.add(i['voiceMethod']);
      row.add(i['voiceFallbackUrl']);
      row.add(i['voiceFallbackMethod']);
      row.add(i['renewalDate']);
      row.add(i['purchaseDate']);
      row.add(i['region']);
      row.add(i['timezone']);
      row.add(i['smsUrl']);
      row.add(i['smsMethod']);
      row.add(i['smsFallbackUrl']);
      row.add(i['smsFallbackMethod']);
      row.add(i['heartbeatUrl']);
      row.add(i['heartbeatMethod']);
      row.add(i['hangupCallbackUrl']);
      row.add(i['hangupCallbackMethod']);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final String dir;
    //Now time in string
    var now = DateTime.now().toString();
    //remove '.;:' from string
    var now2 = now.replaceAll(RegExp(r'[.:]'), '');
    if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download";
    } else {
      dir = (await getApplicationDocumentsDirectory()).path;
    }
    // final String dir = (await getExternalStorageDirectory())!.path;
    print(dir);
    //Time in string

    final String path = '$dir/numbers$now2.csv';

    final File file = File(path);
    await file.writeAsString(csv);
  }
}

_numberDetails(int i, BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Number Details',
                          style: TextStyle(
                              color: ColorHelper.primaryTextColor,
                              fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.close)),
                    ),
                    Divider(
                      thickness: 1,
                    ),

                    //Listview.builder for rows
                    Container(
                      height: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data!['payload'][i].length,
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  snapshots.data['payload'][i].keys
                                              .elementAt(index)
                                              .toString() ==
                                          null
                                      ? ''
                                      : snapshots.data['payload'][i].keys
                                          .elementAt(index)
                                          .toString(),
                                  style: TextStyle(
                                      color: ColorHelper.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text for value

                                Text(snapshots.data['payload'][i].values
                                            .elementAt(index)
                                            .toString() ==
                                        null
                                    ? ''
                                    : snapshots.data['payload'][i].values
                                        .elementAt(index)
                                        .toString()),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: number_list_controller.numberData(),
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
            snapshots = snapshot;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data['payload'].length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  IconHelper.icons[0],
                                  color: ColorHelper.colors[7],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(snapshot.data!['payload'][index]
                                        ['phoneNumber']
                                    .toString()),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(() => EditPhoneNumber(
                                            phoneId: snapshot.data!['payload']
                                                    [index]['phoneNumber']
                                                .toString()));
                                      },
                                      child: Icon(
                                        IconHelper.icons[11],
                                        color: ColorHelper.colors[7],
                                      )),
                                )),
                                SizedBox(
                                  width: 7,
                                ),
                                //Icon button

                                IconButton(
                                    onPressed: () {
                                      _numberDetails(index,context);
                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: ColorHelper.colors[7],
                                    )),
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
