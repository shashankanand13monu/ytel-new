import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ytel/ytel/screens/reporting/logs/controller/log_controller.dart';

import '../../../../helper/constants/colors.dart';
import '../../../../helper/constants/icons.dart';
import '../../../../model/log_model.dart';
import '../../../../utils/extension.dart';

class LogViewPage extends StatefulWidget {
  const LogViewPage({Key? key}) : super(key: key);

  @override
  State<LogViewPage> createState() => _LogViewPageState();
}

class _LogViewPageState extends State<LogViewPage> {
  final LogController logController = Get.put(LogController());
  Logger logger = Logger();
  DateTime? _selectedDate;
  Payload? payload;
  bool loading = false;
  bool isVisible = true;

  TextEditingController _textEditingController = TextEditingController();

  TextEditingController _textEditingController1 = TextEditingController();

  String? SelecttedDateForBackend;
  DateTime currentDate = DateTime.now();

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  //list for dropdown
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String? selectedLocation;

  getLogData() async {
    bool isInternetOn = await check();
    if (isInternetOn) {
      await logController.getSettingData();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLogData();
    print(getLogData());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.colors[6],
          title: Text(
            'Logs',
            style: TextStyle(
              color: ColorHelper.colors[0],
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "SMS"),
              Tab(text: "Calls"),
              Tab(text: "Carrier"),
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
            body('date'),
            body('date'),
            body('date'),
          ],
        ),
      ),
    );
  }

  Widget Check() {
    return Center(
      child: Text(
        "${logController.searchLogModel?.payload![0].date}",
      ),
    );
  }

  Widget body(String type) => ListView.builder(
        //logController.searchLogModel?.payload?.length ?? 0
        itemCount: 1,
        itemBuilder: (context, index) => Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.only(
                  left: 50,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: DropdownButton(
                  hint: const Text(
                    'select items',
                  ),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  value: selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLocation = newValue!;
                    });
                  },
                  items: items.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: TextFormField(
                  controller: _textEditingController,
                  onTap: () {
                    _selectDate(context);
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Start date (UTC)',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 0, right: 30, left: 30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: _textEditingController1,
                  onTap: () {
                    _selectDate1(context);
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'End date (UTC)',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 30, left: 30),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: body12(),
            ),
          ],
        ),
      );

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDate1(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController1
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController1.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  Widget body12() {
    return Container(
      width: double.infinity,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
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
                      flex: 3,
                      child: Text(
                        "${logController.searchLogModel!.payload![index].date! ?? 0}",
                        style: TextStyle(fontSize: 14),
                      ),
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
                      width: 10,
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                      child: Icon(
                        IconHelper.icons[20],
                        color: ColorHelper.colors[2],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
