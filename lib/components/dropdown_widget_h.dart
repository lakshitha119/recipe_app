import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownWidgetH extends StatelessWidget {
  final String selectedValue;
  final Function(String) onChanged;
  final String title;
  final List<String> items;

  DropdownWidgetH({
    required this.selectedValue,
    required this.onChanged, required this.title, required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(width: 10), // Adding space between Text and DropdownButton
        DropdownButton<String>(
          value: selectedValue,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          // Setting a fixed width for DropdownButton
          // You can adjust this value as needed
          // width: 200,
        ),
      ],
    );
  }
}