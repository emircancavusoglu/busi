//sector, du pont, trend, dikey, yatay, oran analizi, risk analizi
// add description of analysis feature to card

import 'package:flutter/material.dart';

class AnalysisTypes extends StatelessWidget {
  const AnalysisTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analiz Türleri'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Ekran genişliğine bağlı olarak 2 sütunlu bir grid
        children: [
          analysisCard("Sektör Analizi", "Oranlarınızı sektörünüzdeki rakiplerinizle karşılaştırın", Icons.calculate_outlined, Colors.blue),
          analysisCard("Du Pont Analizi", "Finansal performansınızı etkileyen faktörleri inceleyin", Icons.bar_chart_outlined, Colors.green),
          analysisCard("Trend Analizi", "Zaman içindeki değişimleri analiz edin", Icons.trending_up_outlined, Colors.orange),
          analysisCard("Dikey Analiz", "Firma içindeki farklı seviyeler arasındaki ilişkileri inceleyin", Icons.vertical_align_center_outlined, Colors.purple),
          analysisCard("Yatay Analiz", "Firma dönemleri arasındaki değişimleri karşılaştırın", Icons.horizontal_split_outlined, Colors.red),
          analysisCard("Oran Analizi", "Firma performansını ölçmek için oranları kullanın", Icons.calculate_outlined, Colors.teal),
          analysisCard("Risk Analizi", "Firma için olası riskleri değerlendirin", Icons.warning_outlined, Colors.amber),
          analysisCard("Karlılık Analizi", "Firma karlılığını analiz edin", Icons.attach_money_outlined, Colors.deepOrange),
        ],
      ),
    );
  }

  Widget analysisCard(String title, String description, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}