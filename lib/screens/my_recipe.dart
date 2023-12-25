import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/recipe_card.dart';
import 'package:recipe_app/screens/recipe_view.dart';

import '../components/circle_loader.dart';
import '../services/api.dart';
import '../utils/constant.dart';


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

    loadData();
  }

  var allFilterList = [];

  loadData() async{
    Timer.run(() {
      CircleLoader.showCustomDialog(context);
    });
    allFilterList = [];

    final value = await APIManager().getRequest(
        Constant.domain + "/api/v1/Recipe/GetByUserName/1");
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
      body:
    ListView.builder(
      itemCount: allFilterList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: RecipeCard(title: allFilterList[index]["name"],desc: " ",onClick: (){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const ViewRecipe(title: "Hello",)));
        },),
        );
      },
    )
    // Column(children: [
    //   RecipeCard(title: "Dhal Curry",desc: " ",onClick: (){
    //       Navigator.of(context)
    //           .push(MaterialPageRoute(builder: (context) => const ViewRecipe(title: "Hello",)));
    //     },),
    //   RecipeCard(title: "Fish Curry",desc: " ",),
    //   ],)


    );
  }
}
