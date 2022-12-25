import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/screens/Number_Management/number_management.dart';
import 'package:ytel/ytel/screens/Number_Management/view/number_set.dart';
import 'package:ytel/ytel/screens/Number_Management/view/number_view.dart';
import 'package:ytel/ytel/screens/Number_Management/view/purchase_number.dart';
import 'package:ytel/ytel/screens/Under_Development/under_devlopment.dart';
import 'package:ytel/ytel/screens/accounts/account_screen.dart';
import 'package:ytel/ytel/screens/chat/page/chats_page.dart';
import 'package:ytel/ytel/screens/contact/view/contact_view.dart';
import 'package:ytel/ytel/screens/dashboard/view/homescreen.dart';
import 'package:ytel/ytel/screens/dashboard/view/logout.dart';
import 'package:ytel/ytel/screens/users/view/user_view.dart';

import '../../../helper/widget/rectangle_contaner.dart';
import '../../../helper/widget/square_container.dart';
import '../../../utils/storage_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Logger logger = Logger();
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _sms;
  late TooltipBehavior _webphone;
  String userName = StorageUtil.getString(StringHelper.ACCOUNT_NAME);

  void connectSocket() {
    io.Socket socket = io.io('ws://13.232.166.194:8000',
        OptionBuilder().setTransports(['websocket']).build());

    socket.connect();
    socket.onConnect((_) {
      logger.d('connect');
    });

    socket.onDisconnect((_) => logger.d('disconnect'));
  }


  @override
  void initState() {
    // connectSocket();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _sms = TooltipBehavior(enable: true);
    _webphone = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.colors[8],
      drawer: _drawer(),
      body: SingleChildScrollView(
        child: Container(
          height: 1210,
          child: Column(
            children: [
              Builder(builder: (context) {
                return appbar(context);
              }),
              body()
            ],
          ),
        ),
      ),
    );
  }

  Widget appbar(context) {
    return Column(
      children: [
        SafeArea(
            child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  color: ColorHelper.colors[6].withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      print("Open Drawer");
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: ColorHelper.colors[7]),
                      child: Center(
                          child: Icon(
                        IconHelper.icons[13],
                        color: ColorHelper.colors[8],
                        size: 15,
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${StringHelper.titles[9]}",
                style: TextStyle(fontSize: 24),
              ),
              Expanded(child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: ColorHelper.colors[6].withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onLongPress: (){

                      },
                      onTap: () {
                        print("Open Drawer");
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: ColorHelper.colors[7]),
                        child: Center(
                            child: Icon(
                              IconHelper.icons[14],
                              color: ColorHelper.colors[8],
                              size: 15,
                            )),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        )),
      ],
    );
  }

  Widget body(){
    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          height: 170,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20,),
                container_rounded("Funds", "NA" , Icon(IconHelper.icons[15],color: ColorHelper.colors[0], size: 44,) , ColorHelper.colors[0] ),
                SizedBox(width: 20,),
                container_rounded("Webphone Users", 1000 , Icon(IconHelper.icons[0],color: ColorHelper.colors[7], size: 44,) , ColorHelper.colors[7]),
                SizedBox(width: 20,),
                container_rounded("UCaaS seats", 0 , Icon(IconHelper.icons[0],color: ColorHelper.colors[10], size: 44,) , ColorHelper.colors[10]),
                SizedBox(width: 20,),
                container_rounded("Numbers", 1722 , Icon(IconHelper.icons[16],color: ColorHelper.colors[4], size: 44,) , ColorHelper.colors[4]),
                SizedBox(width: 20,),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 18,right: 18),
          child: Calls_Chart(),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 18,right: 18),
          child: SMS(),
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 18,right: 18),
          child: WEBphone(),
        )
      ],
    );
  }


  Widget Calls_Chart(){
    return Container(
      height: 280,
      width: double.infinity,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2,bottom: 4),
                child: Text("Calls Chart",style: TextStyle(fontSize: 14,color: ColorHelper.colors[9]),),
              )),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorHelper.colors[8],
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      color: ColorHelper.colors[9].withOpacity(0.80)
                  )
                ]
            ),
            child: SfCartesianChart(

                primaryXAxis: CategoryAxis(),
                // Chart title
                // title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                // legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,

                series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      dataSource:  <SalesData>[
                        SalesData('Mon', 80),
                        SalesData('Tue', 60),
                        SalesData('Wed', 40),
                        SalesData('Thu', 20),
                        SalesData('Fri', 0),
                        SalesData('Sat', 20),
                        SalesData('Sun', 40)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }

  Widget SMS(){
    return Container(
      height: 280,
      width: double.infinity,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2,bottom: 4),
                child: Text("SMS",style: TextStyle(fontSize: 14,color: ColorHelper.colors[9] ),),
              )),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorHelper.colors[8],
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      color: ColorHelper.colors[9].withOpacity(0.80)
                  )
                ]
            ),
            child: SfCartesianChart(

                primaryXAxis: CategoryAxis(),
                // Chart title
                // title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                // legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: _sms,

                series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      dataSource:  <SalesData>[
                        SalesData('Mon', 0),
                        SalesData('Tue', 0),
                        SalesData('Wed', 0),
                        SalesData('Thu', 0),
                        SalesData('Fri', 0),
                        SalesData('Sat', 0),
                        SalesData('Sun', 0)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }

  Widget WEBphone(){
    return Container(
      height: 280,
      width: double.infinity,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2,bottom: 4),
                child: Text("Webphone Users",style: TextStyle(fontSize: 14,color: ColorHelper.colors[9]),),
              )),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorHelper.colors[8],
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      color: ColorHelper.colors[9].withOpacity(0.80)
                  )
                ]
            ),
            child: SfCartesianChart(

                primaryXAxis: CategoryAxis(),
                // Chart title
                // title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                // legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: _webphone,

                series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      dataSource:  <SalesData>[
                        SalesData('Mon', 0),
                        SalesData('Tue', 0),
                        SalesData('Wed', 0),
                        SalesData('Thu', 0),
                        SalesData('Fri', 0),
                        SalesData('Sat', 0),
                        SalesData('Sun', 0)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true)
                  )
                ]
            ),
          ),
        ],
      ),
    );
  }


  Widget container_rounded(title , number , icon , base_color ,){
    return Container(
      height: 150,
      width: 110,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2 , bottom: 4),
                child: Text("${title}",style: TextStyle(fontSize: 14,color: ColorHelper.colors[9] , overflow: TextOverflow.ellipsis),),
              )),
        Container(
        height: 120,
        width: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: ColorHelper.colors[8],
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.0,
                  color: ColorHelper.colors[9].withOpacity(0.80)
              )
            ]
        ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Center(child: icon),
                SizedBox(height: 10,),
                Text("${number}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: base_color),)
              ],
            ),
          ),
      )
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////// DRAWER /////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////
  /////////////////////////////////////////
  //////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
                                               //////////////////////////////////////////////////////////
                                                //////////////////////////////////////////////////////////

  Widget _drawer() => Drawer(
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
                  child: Column(
                    children: [
                      Center(
                        child: Icon(IconHelper.icons[10],size: 94,color: ColorHelper.colors[8],)
                      ),
                      Center(
                        child: Text(userName,style: TextStyle(color: ColorHelper.colors[8],fontSize: 24),),
                      )
                    ],
                  )
                ),
              ),
              _commonTile("Dashboard", const HomeScreen(),
                  "assets/images/monitor.png"),
              _commonTile("Inbox", ChatsPage(), "assets/images/inbox.png"),
              _commonMethod("assets/images/contact.png", "Contacts", [
                _commonListTile("Contacts", const ContactPage()),
                _commonListTile(
                    "Contact Import Status", const UnderDevelopment()),
                _commonListTile("Attributes", const UnderDevelopment()),
              ]),
              _commonMethod("assets/images/project-plan.png", "Workflow", [
                _commonListTile("Workflows", const UnderDevelopment()),
                _commonListTile("Message Templates", const UnderDevelopment()),
                _commonListTile("Webhooks", const UnderDevelopment()),
                _commonListTile("Enrollment", const UnderDevelopment()),
              ]),
              _commonMethod("assets/images/hashtag.png", "Numbers", [
                _commonListTile("Purchase", const PurchaseNumber()),
                _commonListTile("Manage", const NumberManagement()),
                _commonListTile("Number Sets", const NumberSet()),
              ]),
              _commonMethod("assets/images/call-center.png", "Reporting", [
                _commonListTile("Usage", const UnderDevelopment()),
                _commonListTile("Logs", const UnderDevelopment()),
                _commonListTile("Routing statistics", const UnderDevelopment()),
                _commonListTile("Tracking", const UnderDevelopment()),
                _commonListTile("Workflow", const UnderDevelopment()),
                _commonListTile("Workflow failures", const UnderDevelopment()),
                _commonListTile("Workflow paths", const UnderDevelopment()),
              ]),
              _commonMethod("assets/images/settings.png", "Settings", [
                _commonListTile("Billing", const UnderDevelopment()),
                _commonListTile("Accounts", const AccountPage()),
                _commonListTile("Users", const UsersPage()),
                _commonListTile("Buissness Profiles", const UnderDevelopment()),
                _commonListTile("Assets", const UnderDevelopment()),
                _commonListTile("API Tokens", const UnderDevelopment()),
                _commonListTile("Callbacks", const UnderDevelopment()),
                _commonListTile("CNAM Management", const UnderDevelopment()),
                _commonListTile("Compliance", const UnderDevelopment()),
                _commonListTile("Audit", const UnderDevelopment()),
              ]),
              _commonTile("Contact Center", const UnderDevelopment(),
                  "assets/images/customer-care.png"),
              _commonTile("UCaaS", const UnderDevelopment(),
                  "assets/images/telephone.png"),
              _commonTile("Add Feature", const UnderDevelopment(),
                  "assets/images/plus.png"),
              Divider(),
              _commonMethod("assets/images/user_dp.png", userName, [
                _commonListTile("Profile", const UnderDevelopment()),
                _commonListTile("Logout", LogoutDialog()),
              ]),
              _commonMethod("assets/images/information.png", "Help", [
                _commonListTile("Help Articles", const UnderDevelopment()),
                _commonListTile("Product Updates", const UnderDevelopment()),
                _commonListTile("System Status", const UnderDevelopment()),
                _commonListTile("Training videos", const UnderDevelopment()),
                _commonListTile("API", const UnderDevelopment()),
              ]),
              _drawerSearchBar(),
              Divider(),
            ],
          ),
        ),
      );

  Widget _commonMethod(
          String imgPath, String name, List<Widget> listOfWidget) =>
      ExpansionTile(
        leading: Image.asset(
          imgPath,
          height: 32,
          color: Colors.blue,
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: ColorHelper.primaryTextColor,
            fontSize: 17,
          ),
        ),
        children: listOfWidget,
      );

  Widget _commonListTile(String name, Widget navPage) => ListTile(
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

  Widget _commonTile(String name, Widget navPage, String imgPath) => ListTile(
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
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


Widget _drawerSearchBar() => Padding(
  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
