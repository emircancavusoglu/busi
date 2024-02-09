import 'package:busi/network/network_source.dart';
import 'package:busi/network/unemployment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../widget/bottom_navigation_bar.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  bool _isLoading = false;
  void _changeLoading(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }
  Dio dio = Dio(BaseOptions(baseUrl: unemployment));
  @override
  void initState(){
    super.initState();
    fetchPostItems();
  }
  Future<void> fetchPostItems() async {
    _changeLoading();
    final response = await dio.get(unemployment);
    if (response.statusCode == 200) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas
              .map((e) => UnemploymentModel.fromJson(e as Map<String, dynamic>))
              .toList();
        });
      }
    }
    _changeLoading();
  }

  List<UnemploymentModel>? _items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(_items?[index].tarih ?? ''),
          subtitle: Text('İşsizlik Verisi : ${_items?[index].tPTIG08}'),

        );
      },),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
