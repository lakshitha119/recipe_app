import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/home_case_card_ca.dart';
import 'package:recipe_app/screens/recipe_view.dart';

import '../components/circle_loader.dart';


class MyRecipe extends StatefulWidget {

  const MyRecipe({Key? key}) : super(key: key);

  @override
  _MyRecipeState createState() => _MyRecipeState();
}

class _MyRecipeState extends State<MyRecipe> {
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
              "My Recipe",
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

        HomeCaseCardCA(title: "Banana",desc: "serving 100g",onClick: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const ViewRecipe(title: "Hello",)));
        },),
        HomeCaseCardCA(title: "Gova",desc: "serving 100g",),

      ],)),
    );
  }
}
