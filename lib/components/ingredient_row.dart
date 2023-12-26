import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/nutrition_view.dart';

class IngredientRow extends StatelessWidget {
  final String title;
  final String size;

  const IngredientRow({
    Key? key,
    required this.title,
    required this.size,
  }) : super(key: key);
  static const blue = Color.fromARGB(255, 0, 23, 147);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
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
            Text(size,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
