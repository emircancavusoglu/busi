import 'dart:math';

import 'package:busi/prototype/ratio_analysis_results_prototype.dart';
import 'package:flutter/material.dart';

class StressTestingProtoype extends StatelessWidget {
  final List<String> yillar = ['%5', '%10', '%15', '%20', '%25'];
  final List<String> varliklar = ['Dönen Varlıklar', 'Nakit ve Benzerleri', 'Kısa Vadeli Ticari Alacaklar', 'Stoklar', 'Diğer Dönen Varlıklar',];
  final List<String> borclar = ['Finansal Duran Varlıklar', 'Duran Varlıklar', 'Diğer Duran Varlıklar',];
  final List<String> ozkaynaklar = ['Kısa Vadeli Borçlar', 'Finansal Borçlar', 'Ticari Borçlar'];

  // Rastgele sayı üretmek için bir fonksiyon
  double rastgeleSayiUret(double min, double max) {
    final Random rastgele = Random();
    return min + rastgele.nextDouble() * (max - min);
  }

  // Rastgele verilerle bilanço proforma tablosunu oluşturan bir fonksiyon
  List<List<double>> rastgeleVeriUret() {
    final List<List<double>> veriler = [];

    // Varlık (assets) verileri
    for (int i = 0; i < varliklar.length - 1; i++) {
      final List<double> satir = [];
      for (int j = 0; j < yillar.length; j++) {
        satir.add(rastgeleSayiUret(10000, 1000000)); // 10.000 ile 1.000.000 arasında rastgele varlık verisi oluşturur
      }
      veriler.add(satir);
    }

    // Varlıkların toplamı
    final List<double> toplamVarliklar = [];
    for (int j = 0; j < yillar.length; j++) {
      double toplam = 0;
      for (int i = 0; i < varliklar.length - 1; i++) {
        toplam += veriler[i][j];
      }
      toplamVarliklar.add(toplam);
    }
    veriler.add(toplamVarliklar);

    // Borçlar (liabilities) verileri
    for (int i = 0; i < borclar.length - 1; i++) {
      final List<double> satir = [];
      for (int j = 0; j < yillar.length; j++) {
        satir.add(rastgeleSayiUret(1000, 500000)); // 1.000 ile 500.000 arasında rastgele borç verisi oluşturur
      }
      veriler.add(satir);
    }

    // Borçların toplamı
    final List<double> toplamBorclar = [];
    for (int j = 0; j < yillar.length; j++) {
      double toplam = 0;
      for (int i = 0; i < borclar.length - 1; i++) {
        toplam += veriler[i + varliklar.length - 1][j];
      }
      toplamBorclar.add(toplam);
    }
    veriler.add(toplamBorclar);

    // Özkaynak (equity) verileri
    for (int i = 0; i < ozkaynaklar.length - 1; i++) {
      final List<double> satir = [];
      for (int j = 0; j < yillar.length; j++) {
        satir.add(rastgeleSayiUret(1000, 500000000)); // 1.000 ile 500.000 arasında rastgele özkaynak verisi oluşturur
      }
      veriler.add(satir);
    }

    // Özkaynağın toplamı
    final List<double> toplamOzkaynaklar = [];
    for (int j = 0; j < yillar.length; j++) {
      double toplam = 0;
      for (int i = 0; i < ozkaynaklar.length - 1; i++) {
        toplam += veriler[i + varliklar.length + borclar.length - 2][j];
      }
      toplamOzkaynaklar.add(toplam);
    }
    veriler.add(toplamOzkaynaklar);

    return veriler;
  }

  @override
  Widget build(BuildContext context) {
    final List<List<double>> rastgeleVeri = rastgeleVeriUret();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kur Oranı Stres Testi',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleWdiget(),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 10,
          columns: [
            DataColumn(label: Text('')),
            ...yillar.map((yil) => DataColumn(label: Text(yil))),
          ],
          rows: [
            ...varliklar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...rastgeleVeri[varliklar.indexOf(etiket)].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
            ...borclar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...rastgeleVeri[borclar.indexOf(etiket) + varliklar.length - 1].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
            ...ozkaynaklar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...rastgeleVeri[ozkaynaklar.indexOf(etiket) + varliklar.length + borclar.length - 2].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
          ],
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(items: [
      BottomNavigationBarItem(label: "Faiz Stres Testi", icon: Icon(Icons.data_exploration_outlined,color: Colors.blueGrey,)),
      BottomNavigationBarItem(label: "Kredi Stres Testi", icon: Icon(Icons.analytics_outlined,color: Colors.blueGrey,))
    ],),
    );
  }
}
