import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/recipe_card.dart';
import '../screens/build_meal.dart';
import '../screens/nutrition_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/circle_loader.dart';
import '../components/meal_card.dart';
import '../services/api.dart';
import '../utils/constant.dart';

class MyMeal extends StatefulWidget {
  const MyMeal({Key? key}) : super(key: key);

  @override
  _MyMealState createState() => _MyMealState();
}

class _MyMealState extends State<MyMeal> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  var allFilterList = [];

  loadData() async {
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    allFilterList = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = await APIManager().getRequest(Constant.domain +
        "/api/Meals/GetByUserName/${prefs.getString("userid")}");
    if (value != null && value['results'] != null) {
      CircleLoader.hideLoader(context);

      if (value['results'] != 0) {
        setState(() {
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
              "My Meal",
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
      body: ListView.builder(
        itemCount: allFilterList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: MealCard(
                id: allFilterList[index]["id"],
                title: allFilterList[index]["name"],
                desc: allFilterList[index]["mealType"]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your action here
          final result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const BuildMeal()));
          if (result) {
            loadData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
