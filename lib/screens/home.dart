import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/api.dart';
import '../utils/constant.dart';
import '../utils/toast.dart';
import '../components/circle_loader.dart';
import '../components/custom_button.dart';
import '../components/rounded_clickable_icon.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_colors.dart';
import '../utils/indicator.dart';
import 'bar_chart_sample2.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<BarChartSample2State> _barChartSample2Key =
      GlobalKey<BarChartSample2State>();

  final TextEditingController _startDateController =
      TextEditingController(); //Text of TextField
  final TextEditingController _endDateController1 =
      TextEditingController(); //Text of TextField
  List<dynamic> data = []; //ApiPass Body Data Holder
  String title = "Good Morning!";
  int touchedIndex = -1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const yellow = Color(0xfffeb703);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _endDateController1.text = DateTime.now().toString().split(" ")[0];
    DateTime sixDaysAgo = DateTime.now().subtract(Duration(days: 6));
    _startDateController.text = sixDaysAgo.toString().split(" ")[0];
    setTitle();
    loadData();
  }

  generateRandomDarkColor(String NutritionName) {
    switch (NutritionName) {
      case "Total lipid (fat)":
        return Colors.red[300];
      case "Carbohydrate, by difference":
        return Colors.yellow[300];
      case "Cholesterol":
        return Colors.brown[300];
      case "Protein":
        return Colors.green[300];
      default:
        return Colors.grey[300];
    }
  }

  var dateDataList = [];
  loadData() async {
    DateTime date1 = DateTime.parse(_startDateController.text);
    DateTime date2 = DateTime.parse(_endDateController1.text);

    // Calculate the difference in days
    int dateDifference = (date2.difference(date1).inDays);

    // Check if the difference is 6 days
    print("dateDifference $dateDifference");
    if (dateDifference > 6) {
      MyToast.showError("Maximum date range should be 7 days");
      return;
    }
    if (dateDifference < 0) {
      MyToast.showError("Start Date must be less than End Date");
      return;
    }
    print(dateDifference);

    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    APIManager()
        .getRequest(Constant.domain +
            "/api/Dashboard?userName=${prefs.getString("userid")}&startDate=" +
            _startDateController.text +
            "&endDate=" +
            _endDateController1.text)
        .then((res) {
      var pieChart = res["results"]["totalNutritions"];

      _barChartSample2Key.currentState
          ?.fetchDataAndBuildChart(res["results"]["dateWiseNutritions"]);
      indicatorList = [];
      dataList = [];
      for (var pieChartItem in pieChart) {
        var color = generateRandomDarkColor(pieChartItem["name"].toString());
        setState(() {
          // pie chart indicator set up
          indicatorList.add(Container(
              width: Constant.getWidthPartial(context, 80),
              height: 40.0,
              child: Indicator(
                color: color,
                text: pieChartItem["name"],
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0
                    ? AppColors.mainTextColor1
                    : AppColors.mainTextColor3,
              )));
          // provding data for bar chart
          dataList.add(PieChartSectionData(
              color: color,
              value: double.parse(pieChartItem["amount"].toString()),
              title: '',
              radius: 85,
              titlePositionPercentageOffset: 0.98,
              borderSide: false
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
              badgeWidget: Text((pieChartItem["title"].toString()))));
        });
      }
    });
  }

// datapicker
  void _ShowDatePicker(textEditingController) {
    showDatePicker(
        //Color.fromARGB(255, 246, 197, 0)
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2050),
        builder: (context, child) => (Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: blue,
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                  onSurface: blue,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: blue, // button text color
                  ),
                ),
              ),
              child: child!,
            ))).then((value) {
      setState(() {
        textEditingController.text = DateFormat('yyyy-MM-dd').format(value!);
      });
    });
  }

  setTitle() async {
    var today = DateTime.now();
    var curHr = today.hour;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var name = prefs.getString("name");
    if (curHr < 12) {
      setState(() {
        title = 'Good Morning $name!';
      });
    } else if (curHr < 18) {
      setState(() {
        title = 'Good Afternoon $name!';
      });
    } else {
      setState(() {
        title = 'Good Evening $name!';
      });
    }
  }

  List<PieChartSectionData> dataList = [];
  List<Widget> indicatorList = [];

  @override
  Widget build(BuildContext context) {
    //TextEditingController _textEditingController = TextEditingController(); //Text of TextField
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Dashboard',
              style: TextStyle(
                color: yellow,
                fontFamily: "Roboto",
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                color: blue,
                fontFamily: "Roboto",
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      blurRadius: 4,
                      offset: const Offset(0, 1), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //First Selection

                    const Text("Select Date Range"),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: blue,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _startDateController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _startDateController.clear,
                                  icon: const Icon(
                                    Icons.clear,
                                    color: blue,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Color(0xFF006de4)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                  borderSide:
                                      BorderSide(color: blue, width: 2.0),
                                ),
                                hintText: 'Select the Date',
                                //enabled: false,
                              ),
                              readOnly: true,
                            ),
                          ),
                          Container(
                            height: 55,
                            decoration: const BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6))),
                            child: IconButton(
                                icon: const Icon(
                                  Icons.calendar_month_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _ShowDatePicker(_startDateController);
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: blue,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _endDateController1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _endDateController1.clear,
                                  icon: const Icon(
                                    Icons.clear,
                                    color: blue,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Color(0xFF006de4)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                  borderSide:
                                      BorderSide(color: blue, width: 2.0),
                                ),
                                hintText: 'Select the Date',
                                //enabled: false,
                              ),
                              readOnly: true,
                            ),
                          ),
                          Container(
                            height: 55,
                            decoration: const BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6))),
                            child: IconButton(
                                icon: const Icon(
                                  Icons.calendar_month_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _ShowDatePicker(_endDateController1);
                                }),
                          )
                        ],
                      ),
                    ),
                    //SizedBox(height: 10.0,),

                    const SizedBox(
                      height: 10.0,
                    ), //Spacer

                    //Submit Button
                    Container(
                      width: MediaQuery.of(context).size.width / 100 * 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          loadData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ), //S
            const Text(
              'Summary',
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18.0,
                color: blue,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: indicatorList,
                ),
                const SizedBox(
                  height: 1,
                ),
                SizedBox(
                  width: 500,
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: true,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: dataList,
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 800),
                    swapAnimationCurve: Curves.easeInOut,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Overal - Nutrition Consumption',
                  style: TextStyle(fontSize: 16, color: blue),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        width: 500,
                        height: 500,
                        child: BarChartSample2(
                          key: _barChartSample2Key,
                        ))),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Daily - Nutrition Consumption',
                  style: TextStyle(fontSize: 16, color: blue),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// //DropDown List
// const List<String> list = <String>[
//   '- Select Court -',
//   'Supreme Court',
//   'District Court',
//   'Court of Appeal'
// ]; //DropDown Contain List

// class DropdownList extends StatefulWidget {
//   //1. required this.onChanged,
//   final Function onChanged;

//   const DropdownList({
//     Key? key,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   State<DropdownList> createState() => _DropdownButtonExampleState();
// }

// //List Creater
// class _DropdownButtonExampleState extends State<DropdownList> {
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: const Color.fromARGB(255, 0, 23, 147), width: 2.0),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       height: 55,
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: dropdownValue,
//           icon: const Icon(
//             Icons.arrow_drop_down,
//             size: 24.0,
//             color: Color.fromARGB(255, 0, 23, 147),
//           ),
//           elevation: 16,
//           style: const TextStyle(
//             fontSize: 14.0,
//             color: Color.fromARGB(255, 0, 23, 147),
//             fontFamily: "Roboto",
//             fontWeight: FontWeight.bold,
//           ),
//           isExpanded: true,
//           onChanged: (String? value) {
//             // This is called when the user selects an item.
//             setState(() {
//               dropdownValue = value!;
//             });
//             // 2. Call, callback passing the selected value
//             widget.onChanged(value);
//           },
//           items: list.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
