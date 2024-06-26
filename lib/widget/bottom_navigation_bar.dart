import 'package:busi/views/analysis_view/analysis_types.dart';
import 'package:busi/views/analysis_view.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:busi/views/sector/sector_choose.dart';
import 'package:busi/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../consts/navigator.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final tabs = [
    const MainPageView(),
    AnalysisView(),
    SectorChoose(),
    SettingsView(),
  ];
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedIndexProvider>(
      builder: (context, selectedIndex, _) => BottomNavigationBar(
        currentIndex: selectedIndex.selectedIndex,
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: IconButton(onPressed: (){
            NavigateToWidget.navigateToScreen(context, const MainPageView());
          }, icon: const Icon(Icons.home),),label: 'Ana Sayfa',),

          BottomNavigationBarItem(
              icon: IconButton(onPressed: (){
                NavigateToWidget.navigateToScreen(context, const AnalysisTypes());
              },icon: const Icon(Icons.analytics_outlined)),label: 'Analiz Yap'),

          BottomNavigationBarItem(icon: IconButton(onPressed: (){
            NavigateToWidget.navigateToScreen(context, const SectorChoose());
          },icon: const Icon(Icons.format_list_numbered)),label: 'Sektör'),

          BottomNavigationBarItem(icon: IconButton(onPressed: (){
            NavigateToWidget.navigateToScreen(context, const SettingsView());
          },icon: const Icon(Icons.settings)),label: 'Ayarlar'),
        ],
        onTap: (value) => selectedIndex.selectedIndex = value,
      ),
    );
  }
}


class SelectedIndexProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value){
    _selectedIndex = value;
    notifyListeners();
  }
}
