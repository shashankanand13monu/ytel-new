import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ytel/ytel/screens/auth/controller/accounts_controller.dart';

import 'package:ytel/ytel/screens/auth/controller/user_view_controller.dart';
import 'package:csv/csv.dart';
import 'package:ytel/ytel/screens/settings/accounts/create_account.dart';
import 'package:ytel/ytel/screens/settings/accounts/edit_account.dart';
import 'package:ytel/ytel/screens/settings/view/createUser.dart';
import 'package:ytel/ytel/screens/settings/view/editUser_view.dart';

import '../../../helper/constants/colors.dart';
import '../../../helper/constants/icons.dart';



class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
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
      title: Text('Accounts', style: TextStyle(color: Colors.white)),
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
            Get.to(CreateAccount());
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
      future: accounts_controller.data(),
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
                              Text(snapshot.data![index]["name"]
                                  .toString()),
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {
                                      Get.to(() => EditAccountsDetails(snapshot: snapshot.data[index],));
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
                      title: Text('Accounts Details',
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
   "id": "33d666f4-e172-06c0-b22f-bfd02d37e19d",
        "name": "KyleTest001",
        "domain": null,
        "emailAddress": "kyle.test001@ytel.com",
        "contactId": 139577,
        "ytelCompanyId": 111810,
        "isParentAcct": false,
        "parentAcctId": "7c8693c6-976e-4324-9123-2c1d811605f9",
        "phone": null,
        "source": "m360",
        "rateTableRefId": null,
        "smsOptIn": null,
        "createAt": 1566946805771,
        "modifyAt": 1567397023310,
        "firstName": null,
        "lastName": null,
        "status": "inactive"
   */
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add('id');
    row.add('name');
    row.add('domain');
    row.add('emailAddress');
    row.add('contactId');
    row.add('ytelCompanyId');
    row.add('isParentAcct');
    row.add('parentAcctId');
    row.add('phone');
    row.add('source');
    row.add('rateTableRefId');
    row.add('smsOptIn');
    row.add('createAt');
    row.add('modifyAt');
    row.add('firstName');
    row.add('lastName');
    row.add('status');
    rows.add(row);
    


    for(Map m in snapshots.data!){
      List<dynamic> row = [];
      row.add(m['id']);
      row.add(m['name']);
      row.add(m['domain']);
      row.add(m['emailAddress']);
      row.add(m['contactId']);
      row.add(m['ytelCompanyId']);
      row.add(m['isParentAcct']);
      row.add(m['parentAcctId']);
      row.add(m['phone']);
      row.add(m['source']);
      row.add(m['rateTableRefId']);
      row.add(m['smsOptIn']);
      row.add(m['createAt']);
      row.add(m['modifyAt']);
      row.add(m['firstName']);
      row.add(m['lastName']);
      row.add(m['status']);
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

    final String path = '$dir/accounts$now2.csv';
    
    final File file = File(path);
    await file.writeAsString(csv);


  }
  
}


