import 'dart:async';
import 'dart:convert';

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
        backgroundColor: const Color.fromARGB(255, 0, 23, 147),
      ),
      body: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Previous Search Query',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              TextField(
                enabled: false,
                maxLines: 10, // Set maxLines to null for multiline input
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          'Food Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Text(
                          'N1',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Text(
                          'N2',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your action here
          final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SearchQueryAdd()));
          if (result) {
            // loadData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
