import 'dart:async';
import 'dart:convert';

import 'package:MrNutritions/components/searchResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/recipe_card.dart';
import '../screens/nutrition_view.dart';
import '../screens/search_query_add.dart';

import '../components/circle_loader.dart';
import '../components/meal_card.dart';

class SearchQuery extends StatefulWidget {
  const SearchQuery({Key? key}) : super(key: key);

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

    // Timer.run(() {
    //   CircleLoader.showCustomDialog(context);
    // });
    // t = Timer(const Duration(seconds: 3), () {
    //   Timer.run(() {
    //     CircleLoader.hideLoader(context);
    //   });
    // });
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
        itemCount: 16,
        itemBuilder: (context, index) {
          return ListTile(
            title: SearchResult(
                description: "AUTHENTIC BARREL RIPENED FETA CHEESE",
                Protein: "34",
                Lipid: "90",
                Carbohydrate: "45",
                Energy: "38"),
          );
        },
      ),
    );
  }
}
