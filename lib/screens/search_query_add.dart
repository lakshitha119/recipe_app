import 'dart:async';

import 'package:MrNutritions/components/circle_loader.dart';
import 'package:MrNutritions/screens/search_query.dart';
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
  String selectedOrder = "Ascending Order";
  String selectedNutrtionName = "Protein";
  String selectedcategory = "Cheese";

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
      selectedNutrtionName = newValue;
      selectedOrder = newValue;
      selectedcategory = newValue;
    });

    print('Selected value: $selectedNutrtionName');
  }

  search() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SearchQuery()));
    // if (result) {
    //   loadData();
    // }
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

                  const SizedBox(
                    height: 3,
                  ),

                  const Text(
                    'Nutrition Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownWidget(
                    onChanged: (val) {
                      setState(() {
                        selectedNutrtionName = val;
                      });
                    },
                    title: "",
                    items: const [
                      "Protein",
                      "Lipid ",
                      "Carbohydrate",
                      "Cholesterol",
                      "Energy"
                    ],
                    selectedValue: selectedNutrtionName,
                  ),
                  const SizedBox(
                    height: 3,
                  ),

                  const Text(
                    'Food category',
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownWidget(
                    onChanged: (val) {
                      setState(() {
                        selectedcategory = val;
                      });
                    },
                    title: "",
                    items: const [
                      "Cheese",
                      "Ice Cream & Frozen Yogurt",
                      "Breads & Buns",
                      "Cookies & Biscuits",
                      "Fruit & Vegetable Juice, Nectars & Fruit Drinks",
                      "Vegetables"
                    ],
                    selectedValue: selectedcategory,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'Sorting Order',
                    style: TextStyle(fontSize: 16),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: DropdownWidget(
                      onChanged: (val) {
                        setState(() {
                          selectedOrder = val;
                        });
                      },
                      title: "",
                      items: const ["Ascending Order", "Descending Order"],
                      selectedValue: selectedOrder,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
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
                      onPressed: _isDisable
                          ? null
                          : () {
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
