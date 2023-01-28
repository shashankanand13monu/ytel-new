import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as io;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ytel/ytel/helper/constants/colors.dart';
import 'package:ytel/ytel/helper/constants/icons.dart';
import 'package:ytel/ytel/helper/constants/strings.dart';
import 'package:ytel/ytel/utils/custom_drawer.dart';

import '../../../helper/widget/rectangle_contaner.dart';
import '../../../helper/widget/square_container.dart';
import '../../../utils/storage_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Logger logger = Logger();
  String userName =
      StorageUtil.getString(StringHelper.ACCOUNT_NAME);

  void connectSocket() {
    io.Socket socket = io.io(
        'ws://13.232.166.194:8000',
        OptionBuilder()
            .setTransports(['websocket']).build());

    socket.connect();
    socket.onConnect((_) {
      logger.d('connect');
    });

    socket.onDisconnect((_) => logger.d('disconnect'));
  }

  @override
  void initState() {
    // connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: CustomDrawer(),
      body: _body(),
    );
  }

  AppBar _appBar() => AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: ColorHelper.primaryTextColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: ColorHelper.primaryTextColor,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor:
            const Color.fromARGB(255, 206, 228, 247),
      );

  Widget _body() => Container(
        color: const Color.fromARGB(255, 206, 228, 247),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),

              //ListView Builder with horizontal scroll of square containers from containers.dart
              _squareViewContainer(),

              _rectangleViewContainer(),

              const SizedBox(height: 10),
              // syncfusion_flutter_charts stacked line graph
              _stack_chart(),

              const SizedBox(height: 30),

              // Bar Graph
              _bar_graph(),

              const SizedBox(height: 30),
              // Pie Chart of "cost distribution"
              _pie_chart_cost_distribution(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      );

  Widget _squareViewContainer() => SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  SquareContainer(
                    color: ColorHelper.colors[index],
                    icon: IconHelper.icons[index],
                    text: StringHelper.titles[index],
                    value: (index * 10).toString(),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget _rectangleViewContainer() => SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10),
              child: Column(
                children: [
                  RectangleContainer(
                    color: ColorHelper.colors2[index],
                    iconColor: ColorHelper.colors[index],
                    icon: IconHelper.icons[index],
                    title: StringHelper.titles[index],
                    value: (index * 10 + 45).toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget _stack_chart() => Container(
        height: 300,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SfCartesianChart(
          enableAxisAnimation: true,
          primaryXAxis: CategoryAxis(
            //name x-axis
            title: AxisTitle(text: 'Months'),
            //name y-axis
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Total Calls'),
          ),
          // Chart title
          title:
              ChartTitle(text: 'Call inbound and outbound'),
          // Enable legend
          legend: Legend(isVisible: false),
          //Name x-axis

          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'John',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                )),
            LineSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 45),
                  SalesData('Feb', 48),
                  SalesData('Mar', 44),
                  SalesData('Apr', 42),
                  SalesData('May', 50)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'Steve',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false)),
            LineSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 55),
                  SalesData('Feb', 58),
                  SalesData('Mar', 54),
                  SalesData('Apr', 52),
                  SalesData('May', 60)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'Jack',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false))
          ],
        ),
      );

  Widget _bar_graph() => Container(
        height: 300,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title:
              ChartTitle(text: 'Call inbound and outbound'),
          // Enable legend
          legend: Legend(isVisible: false),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<SalesData, String>>[
            ColumnSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'John',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false)),
            ColumnSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 45),
                  SalesData('Feb', 48),
                  SalesData('Mar', 44),
                  SalesData('Apr', 42),
                  SalesData('May', 50)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'Steve',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false)),
            ColumnSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 55),
                  SalesData('Feb', 58),
                  SalesData('Mar', 54),
                  SalesData('Apr', 52),
                  SalesData('May', 60)
                ],
                xValueMapper: (SalesData sales, _) =>
                    sales.year,
                yValueMapper: (SalesData sales, _) =>
                    sales.sales,
                name: 'Jack',
                markerSettings:
                    const MarkerSettings(isVisible: true),
                // Enable data label
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false))
          ],
        ),
      );

  Widget _pie_chart_cost_distribution() => Container(
        height: 300,
        margin: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: SfCircularChart(
          title: ChartTitle(text: 'Call cost distribution'),
          legend: Legend(isVisible: true),
          series: <CircularSeries>[
            DoughnutSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData data, _) =>
                    data.year,
                yValueMapper: (SalesData data, _) =>
                    data.sales,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true))
          ],
        ),
      );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
