import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String desc;
  final dynamic onClick;

  const RecipeCard({
    Key? key,
    this.onClick,
    required this.title,
    required this.desc,
  }) : super(key: key);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
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
          onTap: onClick,
          child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.asset(
                        "assets/images/add.png",
                        scale: 1.8,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                      Text(desc,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Spacer(),
                  Column(

                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 100 * 40,
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
                                backgroundColor: Colors.transparent,
                                elevation: 0),
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
                      SizedBox(height: 5,),
                      Container(
                          width: MediaQuery.of(context).size.width / 100 * 40,
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
                                backgroundColor: Colors.transparent,
                                elevation: 0),
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
