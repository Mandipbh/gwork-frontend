import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/my_profile/my_profile_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedFilter = DashboardFilters.all;
  var formatter = NumberFormat('#0.000');

  final earningsData = [
    ChartData(
        percentage: 39,
        title: 'Cleaning',
        value: 8.4,
        isMoney: true,
        color: const Color(0xffF4D874)),
    ChartData(
        percentage: 24,
        title: 'Babysitting',
        value: 1.3,
        isMoney: true,
        color: Colors.black),
    ChartData(
        percentage: 25,
        title: 'Handyman',
        value: 2.9,
        isMoney: true,
        color: const Color(0xff6DCF82)),
    ChartData(
        percentage: 12,
        title: 'Tutoring',
        value: 3.2,
        isMoney: true,
        color: const Color(0xffEB7373)),
  ];

  final jobsData = [
    ChartData(
        percentage: 39,
        title: 'Pending',
        value: 21,
        color: const Color(0xffF4D874)),
    ChartData(
        percentage: 24, title: 'Published', value: 52, color: Colors.black),
    ChartData(
        percentage: 25,
        title: 'Completed',
        value: 24,
        color: const Color(0xff6DCF82)),
    ChartData(
        percentage: 12,
        title: 'Rejected',
        value: 87,
        color: const Color(0xffEB7373)),
  ];

  final usersData = [
    ChartData(
        percentage: 76,
        title: 'Client',
        value: 123,
        color: const Color(0xffF4D874)),
    ChartData(
        percentage: 24, title: 'Professional', value: 3, color: Colors.black),
  ];

  final applicationsData = [
    ChartData(
        percentage: 52,
        title: 'Pending',
        value: 675,
        color: const Color(0xffF4D874)),
    ChartData(
        percentage: 26, title: 'Accepted', value: 745, color: Colors.black),
    ChartData(
        percentage: 22,
        title: 'Rejected',
        value: 123,
        color: const Color(0xffEB7373)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      body: Stack(
        children: [
          appBarView(),
          Container(
            margin: const EdgeInsets.only(top: 140),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: whiteF2F,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: SingleChildScrollView(
                  child: Column(children: [
                dashboardView(
                    title: 'Earnings',
                    data: selectedFilter == DashboardFilters.today
                        ? []
                        : earningsData,
                    total: 8.4),
                dashboardView(title: 'Jobs', data: jobsData, total: 120),
                dashboardView(title: 'Users', data: usersData, total: 34),
                dashboardView(
                    title: 'Applications', data: applicationsData, total: 67),
                const SizedBox(
                  height: 100,
                ),
              ])),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarView() {
    return Container(
      color: const Color(0xff1B1F1C),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child:
                      Text("ST", style: Theme.of(context).textTheme.headline1),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text(
                    'All Time',
                  ),
                  labelStyle: TextStyle(
                    color: selectedFilter != DashboardFilters.all
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  selected: selectedFilter == DashboardFilters.all,
                  backgroundColor: black343,
                  selectedColor: Colors.white,
                  showCheckmark: false,
                  onSelected: (bool value) {
                    setState(() {
                      selectedFilter = DashboardFilters.all;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text(
                    'Today',
                  ),
                  labelStyle: TextStyle(
                    color: selectedFilter != DashboardFilters.today
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  selected: selectedFilter == DashboardFilters.today,
                  backgroundColor: black343,
                  selectedColor: Colors.white,
                  showCheckmark: false,
                  onSelected: (bool value) {
                    setState(() {
                      selectedFilter = DashboardFilters.today;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text(
                    'This Week',
                  ),
                  labelStyle: TextStyle(
                    color: selectedFilter != DashboardFilters.thisWeek
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  selected: selectedFilter == DashboardFilters.thisWeek,
                  backgroundColor: black343,
                  selectedColor: Colors.white,
                  showCheckmark: false,
                  onSelected: (bool value) {
                    setState(() {
                      selectedFilter = DashboardFilters.thisWeek;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text(
                    'This Month',
                  ),
                  labelStyle: TextStyle(
                    color: selectedFilter != DashboardFilters.thisMonth
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  selected: selectedFilter == DashboardFilters.thisMonth,
                  backgroundColor: black343,
                  selectedColor: Colors.white,
                  showCheckmark: false,
                  onSelected: (bool value) {
                    setState(() {
                      selectedFilter = DashboardFilters.thisMonth;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text(
                    'This Year',
                  ),
                  labelStyle: TextStyle(
                    color: selectedFilter != DashboardFilters.thisYear
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  selected: selectedFilter == DashboardFilters.thisYear,
                  backgroundColor: black343,
                  selectedColor: Colors.white,
                  showCheckmark: false,
                  onSelected: (bool value) {
                    setState(() {
                      selectedFilter = DashboardFilters.thisYear;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboardView(
      {required String title,
      required double total,
      required List<ChartData> data}) {
    if (data.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/images/empty_chart.png', scale: 0.7),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
                const Text(
                  'No data',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: whiteF2F, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: const [
                  Text("There is no data available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4),
                  Text("Check it later or set another filters",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      Map<String, double> dataMap = {};
      List<Color> colorList = [];
      for (var element in data) {
        dataMap[element.title] = element.percentage.toDouble();
        colorList.add(element.color);
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            PieChart(
                dataMap: dataMap,
                colorList: colorList,
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width * 0.3,
                legendOptions: const LegendOptions(showLegends: false),
                chartValuesOptions:
                    const ChartValuesOptions(showChartValues: false),
                ringStrokeWidth: 60),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
                data.first.isMoney
                    ? Text(
                        '€${formatter.format(total)},00',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      )
                    : Text(
                        '$total',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 6, backgroundColor: item.color),
                            const SizedBox(
                              width: 8,
                            ),
                            Text('${item.percentage}% ${item.title}'),
                            const Spacer(),
                            item.isMoney
                                ? Text('€${formatter.format(item.value)},00')
                                : Text('${item.value.toInt()}')
                          ],
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      );
    }
  }
}

class ChartData {
  int percentage;
  String title;
  double value;
  bool isMoney;
  Color color;

  ChartData(
      {required this.percentage,
      required this.color,
      required this.title,
      required this.value,
      this.isMoney = false});
}
