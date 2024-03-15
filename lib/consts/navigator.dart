import 'package:flutter/material.dart';

class NavigateToWidget {
  static void navigateToScreen(BuildContext context, Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
  }
}