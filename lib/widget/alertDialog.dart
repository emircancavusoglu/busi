import 'package:flutter/material.dart';

void alertDialog(BuildContext context,  String title, String message){
  showDialog(
      context: context,
      builder: (BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Tamam"))
      ],
    );
      },);
}