import 'package:busi/views/analysis_view/analysis_types.dart';
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AnalysisTypes(),));
        }, child: Text("Tamam"))
      ],
    );
      },);
}