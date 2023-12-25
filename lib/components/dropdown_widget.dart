import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String selectedValue;
  final Function(String) onChanged;
  final String title;
  final List<String> items;

  DropdownWidget({
    required this.selectedValue,
    required this.onChanged, required this.title, required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      items: items
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}