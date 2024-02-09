import 'package:busi/network/unemployment_model.dart';
import 'package:busi/views/analysis_view.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:busi/views/sector_view.dart';
import 'package:busi/views/settings_view.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final tabs = [
    MainPageView(),
    AnalysisView(),
    SectorView(),
    SettingsView(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Ana Sayfa',),
      BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined),label: 'Analiz Yap'),
      BottomNavigationBarItem(icon: Icon(Icons.format_list_numbered),label: 'Sektör '),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Ayarlar'),
        ],
    onTap: _onTapped
    );
  }
  void _onTapped(int index){
    setState(() {
      selectedIndex = index;
    });
     }
}
