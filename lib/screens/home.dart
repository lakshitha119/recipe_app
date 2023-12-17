import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/rounded_clickable_icon.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../utils/indicator.dart';
import 'bar_chart_sample2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController =
      TextEditingController(); //Text of TextField
  final TextEditingController _textEditingController1 =
      TextEditingController(); //Text of TextField
  List<dynamic> data = []; //ApiPass Body Data Holder
  String title = "Good Morning!";
  int touchedIndex = -1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var isWebView = false;

  var dcSelected = true;
  var scSelected = false;
  var coaSelected = false;
  late Widget webView;
  var currentUrl = "google.com";

  static const yellow = Color(0xfffeb703);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTitle();
  }

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

  setTitle() {
    var today = DateTime.now();
    var curHr = today.hour;

    if (curHr < 12) {
      setState(() {
        title = 'Good Morning!';
      });
    } else if (curHr < 18) {
      setState(() {
        title = 'Good Afternoon!';
      });
    } else {
      setState(() {
        title = 'Good Evening!';
      });
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppColors.contentColorBlue;
        const color1 = AppColors.contentColorYellow;
        const color2 = AppColors.contentColorPink;
        const color3 = AppColors.contentColorGreen;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 10,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              title: '',
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }

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
                height: 15,
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
                      //Spacer

                      const Text("Select Date Range"),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ), //Spacer
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
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _textEditingController.clear,
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
                                    _ShowDatePicker(_textEditingController);
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
                                controller: _textEditingController1,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: _textEditingController1.clear,
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
                                    _ShowDatePicker(_textEditingController1);
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0),
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
                'Summery',
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
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Indicator(
                        color: AppColors.contentColorBlue,
                        text: 'One',
                        isSquare: false,
                        size: touchedIndex == 0 ? 18 : 16,
                        textColor: touchedIndex == 0
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorYellow,
                        text: 'Two',
                        isSquare: false,
                        size: touchedIndex == 1 ? 18 : 16,
                        textColor: touchedIndex == 1
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorPink,
                        text: 'Three',
                        isSquare: false,
                        size: touchedIndex == 2 ? 18 : 16,
                        textColor: touchedIndex == 2
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                      Indicator(
                        color: AppColors.contentColorGreen,
                        text: 'Four',
                        isSquare: false,
                        size: touchedIndex == 3 ? 18 : 16,
                        textColor: touchedIndex == 3
                            ? AppColors.mainTextColor1
                            : AppColors.mainTextColor3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
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
                          show: false,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 0,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  BarChartSample2(),
                ],
              )
            ],
          ),
         ),
    );
  }
}

//DropDown List
const List<String> list = <String>[
  '- Select Court -',
  'Supreme Court',
  'District Court',
  'Court of Appeal'
]; //DropDown Contain List

class DropdownList extends StatefulWidget {
  //1. required this.onChanged,
  final Function onChanged;

  const DropdownList({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownButtonExampleState();
}

//List Creater
class _DropdownButtonExampleState extends State<DropdownList> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 0, 23, 147), width: 2.0),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 55,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 24.0,
            color: Color.fromARGB(255, 0, 23, 147),
          ),
          elevation: 16,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color.fromARGB(255, 0, 23, 147),
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
          isExpanded: true,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
            // 2. Call, callback passing the selected value
            widget.onChanged(value);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
