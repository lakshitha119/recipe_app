import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/dropdown_widget.dart';
import '../utils/toast.dart';


class SearchQueryAdd extends StatefulWidget {
  const SearchQueryAdd({Key? key}) : super(key: key);

  @override
  _SearchQueryAddState createState() => _SearchQueryAddState();
}

class _SearchQueryAddState extends State<SearchQueryAdd> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String selectedValue = "";
  String selectedMeasurement = "G";
  String selectedOp = "1";
  int selectedId = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;
  static const blue = Color.fromARGB(255, 0, 23, 147);
  TextEditingController _servSizeCon = TextEditingController();
  TextEditingController _nutNameCon = TextEditingController();
  TextEditingController _nutValCon = TextEditingController();
  var _isDisable = false;

  @override
  void initState() {
    super.initState();
    _servSizeCon.text = "1";
  }

  void onChanged(String newValue) {
    setState(() {
      selectedMeasurement = newValue;
      selectedValue = selectedValue;
      selectedId = selectedId;
    });

    print('Selected value: $selectedMeasurement');
  }




  search() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: const Row(
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              "Search Query",
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
        backgroundColor: const Color.fromARGB(255, 0, 23, 147),
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

                  const Text(
                    'Serving Size',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    controller: _servSizeCon,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                    'Select Measurement ',
                    style: TextStyle(fontSize: 16),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child:DropdownWidget(
                        onChanged: (val) {
                          setState(() {
                            selectedMeasurement = val;
                          });
                        },
                        title: "",
                        items: const [
                          "G",
                          "KG",
                          "ML",
                          "L",
                          "Cup",
                          "tbl spoon",
                          "t spoon"
                        ],
                        selectedValue:
                        selectedMeasurement,
                      )),
                  const Text(
                    'Nutrition Name',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    enabled: false,
                    controller: _nutNameCon,
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Nutrition Value',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    enabled: false,
                    controller: _nutValCon,
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Operator',
                    style: TextStyle(fontSize: 16),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child:

                    DropdownWidget(
                      onChanged: (val) {
                        setState(() {
                          selectedOp = val;
                        });
                      },
                      title: "",
                      items: const [
                        "1",
                        "2",
                        "3",
                        "4",
                        "5",
                        "6",
                        "7"
                      ],
                      selectedValue:
                      selectedOp,
                    ),),
                  const SizedBox(
                    height: 5,
                  ),

                  const SizedBox(
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
                      onPressed: _isDisable? null :() {


                        search();
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
          ],
        ),
      ),
    );
  }
}
