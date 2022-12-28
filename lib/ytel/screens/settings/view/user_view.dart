import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:csv/csv.dart';
import 'package:ytel/ytel/screens/settings/view/createUser.dart';
import 'package:ytel/ytel/screens/settings/view/editUser_view.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';



class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  AsyncSnapshot<dynamic> snapshots=AsyncSnapshot<dynamic>.nothing();
  

  @override
  void initState() {
    super.initState();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          body(),
        ],
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: ColorHelper.primaryTextColor,
      title: Text('Users', style: TextStyle(color: Colors.white)),
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
            Get.to(CreateUser());
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
      future: user_view_controller.data(),
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
          snapshots=snapshot;
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
                                IconHelper.icons[10],
                                color: ColorHelper.colors[7],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(snapshot.data![index]["firstName"]
                                  .toString()+" "+snapshot.data![index]["lastName"]),
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {
                                      Get.to(() => EditUserDetails(snapshot: snapshot.data[index],));
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
                                    _userDetails(index);
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

_userDetails(int i) {
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
                      title: Text('User Details',
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
                          itemCount: snapshots.data![i].length,
                          
                          itemBuilder: (context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                               
                                Text(
                                  snapshots.data[i].keys.elementAt(index).toString()==null?'':snapshots.data[i].keys.elementAt(index).toString(),
                                  style: TextStyle(
                                      color: ColorHelper.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Text for value
                               
                                Text(snapshots.data[i].values.elementAt(index).toString()==null?'':snapshots.data[i].values.elementAt(index).toString()),
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

  _downloadCSV() async {
    //download csv file of snapshots.data

  //convert in csv
  /*
   "clientId": "10bb0c84-45a2-4d2c-9ca6-5b509a9c8ee5",
        "firstName": "Katelyn",
        "lastName": "QAteam",
        "displayName": null,
        "username": "katelyn+qateam@ytel.com",
        "password": "**********",
        "emailAddress": null,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "belongAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": "",
        "source": null,
        "avatar": null,
        "createAtInEpoch": "2022-10-31T19:45:17.089+00:00",
        "createAt": "2022-10-31T19:45:17Z",
        "webrtcNumber": "+19893246368",
        "inboxes": null,
        "ucaasExtension": null,
        "ucaasCode": null,
        "twoFactorEnabled": null,
        "status": "active",
        "roles": [
            "webrtc-agent"
        ]
   */
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add('clientId');
    row.add('firstName');
    row.add('lastName');
    row.add('displayName');
    row.add('username');
    row.add('password');
    row.add('emailAddress');
    row.add('parentAcctId');
    row.add('belongAcctId');
    row.add('phone');
    row.add('source');
    row.add('avatar');
    row.add('createAtInEpoch');
    row.add('createAt');
    row.add('webrtcNumber');
    row.add('inboxes');
    row.add('ucaasExtension');
    row.add('ucaasCode');
    row.add('twoFactorEnabled');
    row.add('status');
    row.add('roles');
    rows.add(row);


    for(Map m in snapshots.data!){
      List<dynamic> row = [];
      row.add(m['clientId']);
      row.add(m['firstName']);
      row.add(m['lastName']);
      row.add(m['displayName']);
      row.add(m['username']);
      row.add(m['password']);
      row.add(m['emailAddress']);
      row.add(m['parentAcctId']);
      row.add(m['belongAcctId']);
      row.add(m['phone']);
      row.add(m['source']);
      row.add(m['avatar']);
      row.add(m['createAtInEpoch']);
      row.add(m['createAt']);
      row.add(m['webrtcNumber']);
      row.add(m['inboxes']);
      row.add(m['ucaasExtension']);
      row.add(m['ucaasCode']);
      row.add(m['twoFactorEnabled']);
      row.add(m['status']);
      row.add(m['roles']);
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


