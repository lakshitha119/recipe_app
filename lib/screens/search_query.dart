import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/recipe_card.dart';
import 'package:recipe_app/screens/nutrition_view.dart';

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
        backgroundColor: Color.fromARGB(255, 0, 23, 147),
      ),
      body:  SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(children: [

            const Text(
              'Search Query',
              style: TextStyle(fontSize: 16),
            ),

            TextField(
              enabled: false,
              maxLines: 10, // Set maxLines to null for multiline input
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),


            Column(children: [
              Row(children: [
                const Text(
                  'Food Name',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'N1',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'N2',
                  style: TextStyle(fontSize: 16),
                ),
              ],)
            ],)
          ],)),
    );
  }
}
