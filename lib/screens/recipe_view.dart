import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/recipe_card.dart';
import 'package:recipe_app/utils/constant.dart';

import '../components/circle_loader.dart';

class ViewRecipe extends StatefulWidget {
  final String title;

  const ViewRecipe({Key? key, required this.title}) : super(key: key);

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    t = Timer(const Duration(seconds: 3), () {
      Timer.run(() {
        CircleLoader.hideLoader(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              widget.title,
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nutrition Facts",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Text("1 serving per container"),
                  Text("serving size  1 container (259ml)",
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
                      Text("% Daily Value%",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Fat 5g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("6%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("    Stated Fat 0.5g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("3%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Chrolstorol 0g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("0%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sodimum 0g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("0%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Carbydete 0g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("0%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Protien 0g",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text("0%",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ))),
    );
  }
}
