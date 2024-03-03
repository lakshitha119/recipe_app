import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/ingredient_view.dart';
import '../screens/nutrition_view.dart';

class SearchResult extends StatelessWidget {
  final String description;
  final String Protein;
  final String Lipid;
  final String Carbohydrate;
  final String Energy;

  const SearchResult(
      {Key? key,
      required this.description,
      required this.Protein,
      required this.Lipid,
      required this.Carbohydrate,
      required this.Energy})
      : super(key: key);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 4,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: InkWell(
          child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                "assets/images/3565418.png",
                scale: 8,
              )),
          const SizedBox(
            width: 5,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 100 * 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$description",
                      style: const TextStyle(
                          color: blue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  Text("Protein : $Protein",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text("Lipid : $Lipid",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text("Carbohydrate : $Carbohydrate",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text("Energy : $Energy",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold))
                ],
              )),
          // SizedBox(
          //   width: 10,
          // ),
          const Spacer(),
        ],
      )),
    );
  }
}
