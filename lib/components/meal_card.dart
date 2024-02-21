import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/recipe_view.dart';

import '../screens/nutrition_view.dart';

class MealCard extends StatelessWidget {
  final String id;
  final String title;
  final String desc;

  const MealCard({
    Key? key,
    required this.title,
    required this.desc,
    required this.id,
  }) : super(key: key);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
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
                "assets/images/meal.png",
                scale: 3.5,
              )),
          const SizedBox(
            width: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 100 * 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  Text(desc,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold))
                ],
              )),
          Spacer(),
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 100 * 33,
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
                          builder: (context) =>
                              ViewRecipe(id: id, title: title, type: "Meal")));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, elevation: 0),
                    child: const Text(
                      'Recipes',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.0,
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 100 * 33,
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
                              id: id, title: title, type: "Meal")));
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
