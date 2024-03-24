import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/ingredient_row.dart';
import '../utils/constant.dart';

import '../components/circle_loader.dart';
import '../services/api.dart';

class ViewIngredient extends StatefulWidget {
  final String title;
  final String type;
  final String id;
  final String? mealId;

  const ViewIngredient(
      {Key? key,
      required this.title,
      required this.type,
      required this.id,
      this.mealId})
      : super(key: key);

  @override
  _ViewIngredientState createState() => _ViewIngredientState();
}

class _ViewIngredientState extends State<ViewIngredient> {
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
  List<Widget> listViews = [];

  loadNutritionData() {
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    print("${widget.mealId} ${widget.id} ${widget.type}");
    if (widget.type == "Meal") {
      APIManager()
          .getRequest(
              "${Constant.domain}/api/Meals/RecipiesByMealId/${widget.mealId}/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        // var nutritionList = res["results"]["ingredients"][0]["nutritions"];
        var ingredientList = res["results"]["ingredients"];

        if (ingredientList != null) {
          if (ingredientList.length != 0) {
            for (var item in ingredientList) {
              if (item["name"] != null) {
                setState(() {
                  listViews.add(IngredientRow(
                      title: item["name"],
                      size: item["includedSizeInGrams"]
                              .toStringAsFixed(2)
                              .toString() +
                          item["incudedUnit"]));
                });
              }
            }
          }
        } else {}
      });
    } else if (widget.type == "MealRecipe") {
      APIManager()
          .getRequest(
              "${Constant.domain}/api/Meals/RecipiesByMealId/${widget.mealId}/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        // var nutritionList = res["results"]["ingredients"][0]["nutritions"];
        var ingredientList = res["results"]["ingredients"];

        if (ingredientList != null) {
          if (ingredientList.length != 0) {
            for (var item in ingredientList) {
              if (item["name"] != null) {
                setState(() {
                  listViews.add(IngredientRow(
                      title: item["name"],
                      size: item["includedSizeInGrams"]
                              .toStringAsFixed(2)
                              .toString() +
                          item["incudedUnit"]));
                });
              }
            }
          }
        } else {}
      });
    } else {
      APIManager()
          .getRequest("${Constant.domain}/api/v1/Recipe/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        // var nutritionList = res["results"]["ingredients"][0]["nutritions"];
        var ingredientList = res["results"]["ingredients"];

        if (ingredientList != null) {
          if (ingredientList.length != 0) {
            for (var item in ingredientList) {
              if (item["name"] != null) {
                setState(() {
                  listViews.add(IngredientRow(
                      title: item["name"],
                      size: item["includedSize"].toStringAsFixed(2).toString() +
                          item["incudedUnit"]));
                });
              }
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
        backgroundColor: const Color.fromARGB(255, 0, 23, 147),
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
                    offset: const Offset(0, 1), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ingredients",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  // const Text("1 serving per container"),
                  // const Text("serving size  1 container (259ml)",
                  //     style: TextStyle(
                  //         fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const Divider(
                    color: Colors.black,
                    thickness: 10.0,
                  ),

                  Column(
                    children: listViews,
                  )
                ],
              ))),
    );
  }
}
