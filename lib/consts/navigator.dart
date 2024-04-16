import 'package:flutter/material.dart';

class NavigateToWidget {
  static void navigateToScreen(BuildContext context, Widget page){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page,));
  }
}
