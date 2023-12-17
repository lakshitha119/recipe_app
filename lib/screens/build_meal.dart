import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/dropdown_widget.dart';
import '../components/rounded_clickable_icon.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../utils/indicator.dart';
import 'bar_chart_sample2.dart';

class BuildMeal extends StatefulWidget {
  const BuildMeal({Key? key}) : super(key: key);

  @override
  _BuildMealState createState() => _BuildMealState();
}

class _BuildMealState extends State<BuildMeal> {
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

  @override
  Widget build(BuildContext context) {
    //TextEditingController _textEditingController = TextEditingController(); //Text of TextField
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              "Build Meal",
              style: TextStyle(
                fontFamily: "Roboto",
                letterSpacing: 1.0,
                fontSize: 18.0,
                color: Color(0xfffeb703),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 0, 23, 147),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //First Selection
                  //Spacer

                  //Spacer
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
                                borderSide: BorderSide(color: blue, width: 2.0),
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

                  //SizedBox(height: 10.0,),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: DropdownWidget()),
                  const SizedBox(
                    height: 10.0,
                  ),

                  Text(
                    'Enter Recipe',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    enabled: false,
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 100 * 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: const Text(
                        'Add Recipe',
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

                  SizedBox(
                    height: 20,
                  ),

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
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: const Text(
                        'Analyze Meal',
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
