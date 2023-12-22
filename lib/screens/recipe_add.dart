import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/services/state_servies.dart';

import '../components/circle_loader.dart';
import '../components/dropdown_widget.dart';

class RecipeAdd extends StatefulWidget {
  const RecipeAdd({Key? key}) : super(key: key);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  List<dynamic> data = []; //ApiPass Body Data Holder
  String SelectedValueHolder = ""; //Dropdown Button Selected Value Holder
  String selectedValue = ""; //Dropdown Button Selected Value Holder

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer t;
  static const blue = Color.fromARGB(255, 0, 23, 147);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController1 = TextEditingController();
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
    _textEditingController.text = "250 gram beans \n1 tablespoon oilve oil";
    _textEditingController1.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: const [
            SizedBox(
              width: 1,
            ),
            Text(
              "Add Recipe",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //First Selection
                  //Spacer

                  Text(
                    'Enter Recipe Name',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width / 100 * 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40,
                                        top: -40,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: TypeAheadField<String>(
                                                suggestionsCallback: (value) {
                                                  return StateService
                                                      .getSuggestions(value);
                                                },
                                                builder: (context, controller,
                                                    focusNode) {
                                                  return TextField(
                                                      controller: controller,
                                                      focusNode: focusNode,
                                                      autofocus: true,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Search For Ingredient'));
                                                },
                                                itemBuilder: (context, city) {
                                                  return ListTile(
                                                    title: Text(city),
                                                  );
                                                },
                                                onSelected: (city) {

                                                  setState(() {
                                                    selectedValue = city;
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(selectedValue),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: TextField(
                                                  autofocus: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Amount')),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: DropdownWidget(
                                                  title: "Select Measurement",
                                                  items: [
                                                    "Op1",
                                                    "Op2",
                                                    "Op3",
                                                    "Op4"
                                                  ],
                                                  selected: "Op1",
                                                )),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                child: const Text('Add'),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: const Text(
                        'Add Ingredient',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const Text(
                    'Selected Recipe Ingredient',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    enabled: false,
                    controller: _textEditingController,
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Text(
                    'Select Number of Serving ',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    controller: _textEditingController1,
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Text(
                    'Selected Serving Unit',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextField(
                    maxLines: null, // Set maxLines to null for multiline input
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Submit Button
                  Container(
                    width: MediaQuery.of(context).size.width / 100 * 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0),
                      child: const Text(
                        'Analyze Recipe',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
