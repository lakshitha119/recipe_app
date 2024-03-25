import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/ingredient_view.dart';
import '../screens/nutrition_view.dart';

class SearchResult extends StatelessWidget {
  final String description;
  final List<dynamic> Nutirions;

  const SearchResult(
      {Key? key, required this.description, required this.Nutirions})
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
                "assets/images/6951865.png",
                scale: 7.5,
              )),
          const SizedBox(
            width: 5,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 100 * 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$description",
                      style: const TextStyle(
                          color: blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: Nutirions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(
                            Nutirions[index]["nutrientName"] +
                                " : " +
                                Nutirions[index]["value"].toString() +
                                Nutirions[index]["unitName"],
                            style: const TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ],
              )),
          // SizedBox(
          //   width: 10,
          // ),
        ],
      )),
    );
  }
}
