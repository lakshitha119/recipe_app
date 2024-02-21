import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/ingredient_row.dart';
import 'package:recipe_app/utils/constant.dart';

import '../components/circle_loader.dart';
import '../components/recipe_card.dart';
import '../services/api.dart';

class ViewRecipe extends StatefulWidget {
  final String title;
  final String type;
  final String id;

  const ViewRecipe(
      {Key? key, required this.title, required this.type, required this.id})
      : super(key: key);

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    if (widget.type == "Meal") {
      APIManager()
          .getRequest("${Constant.domain}/api/Meals/${widget.id}")
          .then((res) {
        CircleLoader.hideLoader(context);

        // var nutritionList = res["results"]["ingredients"][0]["nutritions"];
        var recipeList = res["results"]["recipes"];

        if (recipeList != null) {
          if (recipeList.length != 0) {
            for (var item in recipeList) {
              if (item["name"] != null) {
                setState(() {
                  listViews.add(RecipeCard(
                    id: item["id"],
                    title: item["name"],
                    desc: " ",
                    mealId: res["results"]["id"],
                    type: "Meal",
                  ));
                });
              }
            }
          }
        } else {}
      });
    } else {}
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
                  const Text("Recipes",
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
                  SizedBox(
                    height: 10,
                  ),

                  Column(
                    children: listViews,
                  )
                ],
              ))),
    );
  }
}
