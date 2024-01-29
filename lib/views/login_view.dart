import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final String username = 'userDeneme';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Welcome To BusiCount $username'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
          ],
        ),
      )
    );
  }
}
