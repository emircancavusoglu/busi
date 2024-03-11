import 'package:busi/views/analysis_types.dart';
import 'package:busi/views/analysis_view.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:busi/views/sector_view.dart';
import 'package:busi/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final tabs = [
    const MainPageView(),
    AnalysisView(),
    const SectorView(),
    const SettingsView(),
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
                },icon: const Icon(Icons.analytics_outlined)),label: 'Finansal Analiz'),

            BottomNavigationBarItem(icon: IconButton(onPressed: (){
              NavigateToWidget.navigateToScreen(context, const SectorView());
            },icon: const Icon(Icons.format_list_numbered)),label: 'Satış Analizi'),

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

class NavigateToWidget{
  static void navigateToScreen(BuildContext context, Widget page)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
  }
}
