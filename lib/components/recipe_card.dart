import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/ingredient_view.dart';
import '../screens/nutrition_view.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String desc;
  final String id;
  final String? mealId;
  final String type;

  const RecipeCard(
      {Key? key,
      required this.title,
      required this.desc,
      required this.id,
      this.mealId,
      this.type = "Recipe"})
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
              width: MediaQuery.of(context).size.width / 100 * 29,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  Text(desc,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold))
                ],
              )),
          // SizedBox(
          //   width: 10,
          // ),
          const Spacer(),
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 100 * 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewIngredient(
                                id: id,
                                title: title,
                                type: type,
                                mealId: mealId,
                              )));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.0,
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 100 * 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [blue, Color.fromARGB(255, 4, 34, 193)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NutritionView(
                              id: id, title: title, type: "Recipe")));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: const Text(
                      'Nutrition',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.0,
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ],
          )
        ],
      )),
    );
  }
}
