import 'package:busi/network/network_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  Dio dio = Dio(BaseOptions(baseUrl: unemployment));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(

        itemBuilder: (context, index) {
        return ListTile();
      },),
    );
  }
}
