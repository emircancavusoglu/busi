//sector, du pont, trend, dikey, yatay, oran analizi, risk analizi
// add description of analysis feature to card

import 'package:busi/views/analysis_view.dart';
import 'package:busi/views/analysis_view/du_pont_analysis_view.dart';
import 'package:busi/views/analysis_view/horizontal_analysis_view.dart';
import 'package:busi/views/analysis_view/profitable_analysis_view.dart';
import 'package:busi/views/analysis_view/ratio_analysis_view.dart';
import 'package:busi/views/analysis_view/risk_analysis_view.dart';
import 'package:busi/views/analysis_view/sector_analysis_view.dart';
import 'package:busi/views/analysis_view/trend_analysis_view.dart';
import 'package:busi/views/analysis_view/vertical_analysis.dart';
import 'package:busi/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class AnalysisTypes extends StatelessWidget {
  const AnalysisTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analiz Türleri'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          analysisCard(context, "Sektör Analizi", "Oranlarınızı sektörünüzdeki rakiplerinizle karşılaştırın", Colors.blue),
          analysisCard(context, "Du Pont Analizi", "Finansal performansınızı etkileyen faktörleri inceleyin", Colors.green),
          analysisCard(context, "Trend Analizi", "Zaman içindeki değişimleri analiz edin", Colors.orange),
          analysisCard(context, "Dikey Analiz", "Firma içindeki farklı seviyeler arasındaki ilişkileri inceleyin", Colors.purple),
          analysisCard(context, "Yatay Analiz", "Firma dönemleri arasındaki değişimleri karşılaştırın", Colors.red),
          analysisCard(context, "Oran Analizi", "Firma performansını ölçmek için oranları kullanın", Colors.teal),
          analysisCard(context, "Risk Analizi", "Firmanız için olası riskleri makine öğrenmesi teknikleri ile değerlendirin", Colors.amber),
          analysisCard(context, "Karlılık Analizi", "Firma karlılığını analiz edin", Colors.deepOrange),
          analysisCard(context, "Genel Analizi", "Firmanızın ihtiyaçlarını tespit edin", Colors.blue),
          analysisCard(context, "Pazar Analizi", "Firmanıza özelleştirilmiş rakip ve pazar analizi yapın", Colors.green),
        ],
      ),
    );
  }

  Widget analysisCard(BuildContext context, String title, String description, Color color) {
    late Widget destinationScreen;

    switch(title){
      case 'Sektör Analizi':
        destinationScreen = SectorAnalysisView();
        break;
      case 'Du Pont Analizi':
        destinationScreen = DuPontAnalysisView();
        break;
      case 'Trend Analizi':
        destinationScreen = TrendAnalysisView();
        break;
      case 'Dikey Analiz':
        destinationScreen = VerticalAnalysisView();
        break;
      case 'Yatay Analiz':
        destinationScreen = HorizontalAnalysisView();
        break;
      case 'Oran Analizi':
        destinationScreen = RatioAnalysisView();
        break;
      case 'Risk Analizi':
        destinationScreen = RiskAnalysisView();
        break;
      case 'Karlılık Analizi':
        destinationScreen = ProfitableAnalysisView();
        break;
      default:
        destinationScreen = AnalysisView();
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
