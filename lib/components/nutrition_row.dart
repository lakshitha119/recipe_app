
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/nutrition_view.dart';

class NutritionRow extends StatelessWidget {
  final String title;
  final String amount;

  const NutritionRow({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
    Container(
        width: MediaQuery.of(context).size.width / 100 * 70,
        child: Text(title,
                softWrap: true,
                style: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold))),
            Text(amount+"%",
                style: TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),],
    );
  }
}
