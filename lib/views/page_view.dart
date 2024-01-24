import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: const Image(
              image: AssetImage('assets/busi-logo-white.png'),
            ),
          ),
          Container(
            color: Colors.grey,
            child: Center(
              child: Text(
                "BusiCount",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
