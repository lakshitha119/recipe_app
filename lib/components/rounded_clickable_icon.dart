import 'package:flutter/material.dart';

class RoundedClickableIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double padding;
  final bool showNotification;

  const RoundedClickableIcon({Key? key,
    required this.icon,
    this.color = Colors.black45,
    this.padding = 10.0,
    this.showNotification = false,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Stack(
      children: [
       Padding(
         padding: const EdgeInsets.only(top:5),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child:Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
       ),
        showNotification ? Positioned(
          top:15,
          right: 10,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
