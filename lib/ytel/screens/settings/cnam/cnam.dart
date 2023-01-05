import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ytel/ytel/screens/settings/cnam/cnam_controller.dart';
import 'package:ytel/ytel/screens/settings/cnam/create_cnam.dart';
import 'package:ytel/ytel/utils/storage_utils.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';
import '../../../helper/constants/strings.dart';
import '../../../services/interceptors.dart';

class CnamPage extends StatefulWidget {
  const CnamPage({super.key});

  @override
  State<CnamPage> createState() => _CnamPageState();
}

class _CnamPageState extends State<CnamPage> {
  AsyncSnapshot<dynamic> snapshots = AsyncSnapshot<dynamic>.nothing();
    TextEditingController searchController = TextEditingController();
    bool search_pressed = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          if(search_pressed) _searchNo(),

          body(),
        ],
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: ColorHelper.primaryTextColor,
      title: Text('CNAM Management', style: TextStyle(color: Colors.white)),
      //Search icon in the end of appbar
      actions: [
        
        IconButton(
          onPressed: () {
            setState(() {
              search_pressed = !search_pressed;
            });
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Get.to(() => CreateCnam());
          },
          icon: Icon(Icons.add),
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

  body() {
    return Expanded(
        child: Center(
      child: FutureBuilder(
        future: cnam_controller.data(),
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
                                Text(snapshot.data!['payload'][index]['cnam']
                                    .toString()),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        
                                      },
                                      child: Icon(
                                        IconHelper.icons[21],
                                        color: ColorHelper.colors[7],
                                      )),
                                )),
                                SizedBox(
                                  width: 7,
                                ),
                                //Icon button

                                IconButton(
                                    onPressed: () {
                                      _numberDetails(index);
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

  _numberDetails(int i) {
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
                      title: Text('Cnam Details',
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

}