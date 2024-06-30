import 'package:busi/consts/navigator.dart';
import 'package:busi/views/advices.dart';
import 'package:busi/views/analysis_view/proforma.dart';
import 'package:busi/views/analysis_view/ratio.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:flutter/material.dart';

class AnalysisTypes extends StatelessWidget {
  const AnalysisTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analiz Türleri'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPageView(),
              ),
            );
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 1, // Her kartın tam genişliği kaplaması için 1 sütun kullan
        padding: const EdgeInsets.all(8.0), // Kartların etrafındaki boşluk
        childAspectRatio: 3 / 2, // Kartların yüksekliğini ayarlamak için en-boy oranı
        children: [
          analysisCard(
            context,
            'Proforma',
            'Geleceğe Yönelik Tablolarınızı Oluşturun',
            Colors.green,
          ),
          analysisCard(
            context,
            'Oran Analizi',
            'Firma performansını ölçmek için oranları kullanın',
            Colors.teal,
          ),
          analysisCard(
            context,
            'Tavsiyeler',
            'Firmanıza özelleştirilmiş pazar analizi, ve oran analizi sonuçlarına göre tavsiyeler alın',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget analysisCard(
      BuildContext context,
      String title,
      String description,
      Color color,
      ) {
    late Widget destinationScreen;

    switch (title) {
      case 'Tavsiyeler':
        destinationScreen = Advices(
          key: key,
          sector: '',
        );
      case 'Proforma':
        destinationScreen = const ProformaAnalysis();
      case 'Oran Analizi':
        destinationScreen = const RatioAnalysis();
        break;
    }

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),

      margin: const EdgeInsets.all(8), // Kartların arasındaki boşluk
      child: InkWell(
        onTap: () {
          NavigateToWidget.navigateToScreen(context, destinationScreen);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(title),
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
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
      ),
    );
  }

  IconData _getIconData(String title) {
    switch (title) {
      case 'Oran Analizi':
        return Icons.calculate_outlined;
      case 'Tavsiyeler':
        return Icons.thumb_up_alt;
      case 'Proforma':
        return Icons.area_chart_outlined;
      default:
        return Icons.trending_up_outlined;
    }
  }
}
