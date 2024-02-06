import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
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
      _selectedIndex = index;
    });
     }
}
