import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/nutrition_row.dart';
import '../components/recipe_card.dart';
import '../utils/constant.dart';

import '../components/circle_loader.dart';
import '../services/api.dart';

class NutritionView extends StatefulWidget {
  final String title;
  final String id;
  final String type;
  final String? mealid;
  const NutritionView(
      {Key? key,
      required this.title,
      required this.type,
      required this.id,
      this.mealid})
      : super(key: key);

  @override
  _NutritionViewState createState() => _NutritionViewState();
}

class _NutritionViewState extends State<NutritionView> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;

  @override
  void initState() {
    super.initState();

    loadNutritionData();
  }

  var nutritionList = [];
  List<Widget> nutritionListViews = [];

  loadNutritionData() {
    print("type :- ${widget.type}");
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    if (widget.type == "Meal") {
      print("${Constant.domain}/api/Meals/${widget.id}");
      APIManager()
          .getRequest("${Constant.domain}/api/Meals/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        var totalNuritionList = res["results"]["totalNuritions"];

        if (totalNuritionList != null) {
          if (totalNuritionList.length != 0) {
            for (var item in totalNuritionList) {
              var amount =
                  item["amountByIngredientSize"].toStringAsFixed(2).toString();
              setState(() {
                nutritionListViews.add(NutritionRow(
                    title: item["name"], amount: amount + item["unitName"]));
                // nutritionList = nutritionList;
              });
            }
          }
        } else {}
      });
    } else if (widget.type == "MealRecipe") {
      print(
          "${Constant.domain}/api/Meals/RecipiesByMealId/${widget.mealid}/${widget.id}");
      APIManager()
          .getRequest(
              "${Constant.domain}/api/Meals/RecipiesByMealId/${widget.mealid}/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        var ingredientList = res["results"]["ingredients"];

        if (ingredientList != null) {
          print("ingredientList");
          print(ingredientList);
          for (var ing in ingredientList) {
            var nutritionList = ing["nutritions"];
            if (ing["name"] != null) {
              nutritionListViews.add(Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 10),
                  child: Text(ing["name"].toString(),
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800))));
              if (nutritionList != null) {
                if (nutritionList.length != 0) {
                  for (var item in nutritionList) {
                    var amount = item["amountByIngredientSize"]
                        .toStringAsFixed(2)
                        .toString();
                    setState(() {
                      nutritionListViews.add(NutritionRow(
                          title: item["name"],
                          amount: amount + item["unitName"]));
                      // nutritionList = nutritionList;
                    });
                  }
                }
              } else {}
            }
          }
        } else {}
      });
    } else {
      APIManager()
          .getRequest(Constant.domain + "/api/v1/Recipe/" + widget.id)
          .then((res) {
        CircleLoader.hideLoader(context);

        var ingredientList = res["results"]["ingredients"];

        if (ingredientList != null) {
          print("ingredientList");
          print(ingredientList);
          for (var ing in ingredientList) {
            var nutritionList = ing["nutritions"];
            if (ing["name"] != null) {
              nutritionListViews.add(Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 10),
                  child: Text(ing["name"].toString(),
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800))));
              if (nutritionList != null) {
                if (nutritionList.length != 0) {
                  for (var item in nutritionList) {
                    var amount = item["amountByIngredientSize"]
                        .toStringAsFixed(2)
                        .toString();
                    setState(() {
                      nutritionListViews.add(NutritionRow(
                          title: item["name"],
                          amount: amount + item["unitName"]));
                      // nutritionList = nutritionList;
                    });
                  }
                }
              } else {}
            }
          }
        } else {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const SizedBox(
              width: 1,
            ),
            Text(
              widget.title,
              style: const TextStyle(
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
          child: Container(
              width: Constant.getWidthPartial(context, 100.00),
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 4,
                    offset: Offset(0, 1), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nutrition Facts",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Text("serving size" "total weight",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Divider(
                    color: Colors.black,
                    thickness: 10.0,
                  ),
                  Text("amount per serving",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Calories",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                      Text("150",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                      Text("Amount with unit",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: nutritionListViews,
                  )
                ],
              ))),
    );
  }
}
