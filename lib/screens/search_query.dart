import 'dart:async';
import 'dart:convert';

import 'package:MrNutritions/components/searchResult.dart';
import 'package:MrNutritions/services/api.dart';
import 'package:MrNutritions/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/recipe_card.dart';
import '../screens/nutrition_view.dart';
import '../screens/search_query_add.dart';

import '../components/circle_loader.dart';
import '../components/meal_card.dart';

class SearchQuery extends StatefulWidget {
  final String selectedNutrtionName;
  final String selectedOrder;
  final String selectedcategory;

  const SearchQuery({
    Key? key,
    required this.selectedNutrtionName,
    required this.selectedOrder,
    required this.selectedcategory,
  }) : super(key: key);

  @override
  _SearchQueryState createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQuery> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;

  @override
  void initState() {
    super.initState();
    loadData();

    // Timer.run(() {
    //   CircleLoader.showCustomDialog(context);
    // });
    // t = Timer(const Duration(seconds: 3), () {
    //   Timer.run(() {
    //     CircleLoader.hideLoader(context);
    //   });
    // });
  }

  var allFilterList = [];
  var sortingOrder = 7;
  loadData() async {
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    allFilterList = [];
    if (widget.selectedOrder == "Ascending Order") {
      sortingOrder = 0;
    } else {
      sortingOrder = 1;
    }
    print("order" + sortingOrder.toString());
    final value = await APIManager().getRequest(Constant.domain +
//"/api/SearchQuery?category=Cheese&nutrtionName=Protein&sortingOrder=0");
        "/api/SearchQuery?category=" +
        widget.selectedcategory +
        "&nutrtionName=" +
        widget.selectedNutrtionName +
        "&sortingOrder=" +
        sortingOrder.toString());
    if (value != null && value['results'] != null) {
      CircleLoader.hideLoader(context);

      if (value['results'] != 0) {
        setState(() {
          print(value['results']);
          allFilterList = value['results'];
        });
        return allFilterList;
      } else {
        return allFilterList;
      }
    }
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
              "Search Query Result",
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
      body: ListView.builder(
        shrinkWrap: true, // -> Add this here
        scrollDirection: Axis.vertical,
        itemCount: allFilterList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: SearchResult(
                description: allFilterList[index]["description"],
                Nutirions: allFilterList[index]["foodNutrients"]),
          );
        },
      ),
    );
  }
}
