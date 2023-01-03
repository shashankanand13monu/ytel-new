import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/model/setting_assets_model.dart';

import '../../../utils/extension.dart';
import '../controller/setting_assets_controller.dart';

class SettingAssetView extends StatefulWidget {
  const SettingAssetView({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingAssetView> createState() => _SettingAssetViewState();
}

class _SettingAssetViewState extends State<SettingAssetView> {
  @override
  final Setting_Assets_Controller setting_assets_controller =
      Get.put(Setting_Assets_Controller());

  Payload? payload;
  bool loading = false;

  getSettingAssetData() async {
    bool isInternetOn = await check();
    if (isInternetOn) {
      await setting_assets_controller.getSettingData();
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSettingAssetData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.colors[6],
          title: Text(
            'Assets',
            style: TextStyle(
              color: ColorHelper.colors[0],
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Audio"),
              Tab(text: "Images"),
              Tab(text: "XML"),
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
            body('audio'),
            body('mms-image'),
            body('inboundxml'),
          ],
        ),
      ),
    );
  }

  Widget body(String type) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: setting_assets_controller.settingAssetsModel?.payload
                      ?.where((element) => element.type == type)
                      .toList()
                      .length ??
                  0,
              itemBuilder: (context, index) {
                final settingAssetModel = setting_assets_controller
                    .settingAssetsModel?.payload
                    ?.where((element) => element.type == type)
                    .toList()[index];
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
                        Expanded(
                          flex: 4,
                          child: Text("${settingAssetModel?.name!.toString()}"),
                        ),

                        // AutoSizeText(
                        //   snapshot.data['payload'][index]['name'] == null
                        //       ? 'NULL'
                        //       : snapshot.data['payload'][index]['name'],
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //   ),
                        //   maxLines: 3,
                        //   minFontSize: 18,
                        // ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                IconHelper.icons[11],
                                color: ColorHelper.colors[7],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          //  onTap: setting_assets_controller.,
                          child: Icon(
                            IconHelper.icons[12],
                            color: ColorHelper.colors[2],
                          ),
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
}
