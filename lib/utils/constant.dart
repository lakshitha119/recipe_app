import 'package:flutter/cupertino.dart';

class Constant {

  static const domain = "https://api.textware.lk";



  static double getHeightPartial(BuildContext context, double partial) {
    return MediaQuery.of(context).size.height/100 * partial;
  }

  static double getWidthPartial(BuildContext context, double partial) {
    return MediaQuery.of(context).size.width/100 * partial;
  }

}