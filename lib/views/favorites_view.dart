import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  final String newText = "";
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Henüz favorilerinize veri eklemediniz.'))
        ],
      ),
    );
  }
}
