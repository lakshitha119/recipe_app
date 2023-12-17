import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final bool selected;
  final dynamic onClick;

  const CustomButton({
    Key? key,
    required this.title,
    required this.selected, this.onClick, required this.width,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: selected
              ? [const Color(0xFFFEB703), const Color(0xFFEFB208)]
              : [const Color.fromARGB(255, 0, 23, 147), const Color.fromARGB(
          255, 4, 34, 193)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, elevation: 0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 14.0,
            color: selected ? const Color(0xFF012557) : Colors.white,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
