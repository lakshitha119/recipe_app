import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/constant.dart';

class DropdownWidget extends StatefulWidget {

  final String title;
  final String selected;
  final List<String> items;

  DropdownWidget({required this.title, required this.items, required this.selected});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        Container(
            width: Constant.getWidthPartial(context, 90.0),
            height: 40,
            decoration: const BoxDecoration(
                color: Color(0xffb4cfef),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: widget.items
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
      ],
    );
  }
}
