import 'package:busi/consts/navigator.dart';
import 'package:busi/views/advices.dart';
import 'package:busi/views/analysis_view/ratio.dart';
import 'package:busi/views/analysis_view/proforma.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


var userUid = "uid"; //fixme

class AnalysisTypes extends StatelessWidget {
  const AnalysisTypes({ super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analiz Türleri'),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              MainPageView(),));
        }, icon: const Icon(Icons.chevron_left)),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          analysisCard(context, 'Proforma', 'Geleceğe Yönelik Tablolarınızı Oluşturun',
              Colors.green,),
          analysisCard(context, 'Oran Analizi', 'Firma performansını ölçmek için oranları kullanın',
              Colors.teal,),
          analysisCard(context, 'Tavsiyeler', 'Firmanıza özelleştirilmiş pazar analizi, ve oran analizi sonuçlarına göre tavsiyeler alın', Colors.green),
        ],
      ),
    );
  }
  Widget analysisCard(BuildContext context, String title, String description,
      Color color,) {
    late Widget destinationScreen;

    switch(title){
      case 'Tavsiyeler':
        destinationScreen = Advices(
          key: key, sector: 'Yiyecek',

        );
        break;
      case 'Proforma':
        destinationScreen =  const ProformaAnalysis();
        break;
      case 'Oran Analizi':
        destinationScreen = RatioAnalysis();
        break;
    }
  return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          NavigateToWidget.navigateToScreen(context, destinationScreen);
          },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(
                _getIconData(title),
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                NavigateToWidget.navigateToScreen(context, destinationScreen);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String title) {
    switch (title) {
      case 'Sektör Analizi':
        return Icons.ssid_chart_outlined;
      case 'Du Pont Analizi':
        return Icons.bar_chart_outlined;
      case 'Trend Analizi':
        return Icons.trending_up_outlined;
      case 'Dikey Analiz':
        return Icons.vertical_align_center_outlined;
      case 'Yatay Analiz':
        return Icons.horizontal_split_outlined;
      case 'Oran Analizi':
        return Icons.calculate_outlined;
      case 'Risk Analizi':
        return Icons.warning_outlined;
      case "Karlılık Analizi":
        return Icons.attach_money_outlined;
      case "Genel Analiz":
        return Icons.timeline;
      case "Pazar Analizi":
        return Icons.area_chart_outlined;
      default:
        return Icons.error_outline;
    }
  }
}
