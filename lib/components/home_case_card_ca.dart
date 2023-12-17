import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCaseCardCA extends StatelessWidget {
  final String title;
  final String desc;
  final dynamic onClick;

  const HomeCaseCardCA({
    Key? key,
    this.onClick,required this.title, required this.desc,
  }) : super(key: key);

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
          child:  Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                "assets/images/add.png",
                scale: 1.2,
              )),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(desc,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold))
            ],
          )
        ],
      )),
    );
  }
}
