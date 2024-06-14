import 'dart:math';
import 'package:busi/prototype/ratio_analysis_results_prototype.dart';
import 'package:flutter/material.dart';

class BilancoProforma extends StatelessWidget {
  final List<String> yillar = ['Yıl 1', 'Yıl 2', 'Yıl 3', 'Yıl 4', 'Yıl 5'];
  final List<String> varliklar = ['Dönen Varlıklar', 'Nakit ve Benzerleri', 'Kısa Vadeli Ticari Alacaklar', 'Stoklar', 'Diğer Dönen Varlıklar'];
  final List<String> borclar = ['Finansal Duran Varlıklar', 'Duran Varlıklar', 'Diğer Duran Varlıklar'];
  final List<String> ozkaynaklar = ['Kısa Vadeli Borçlar', 'Finansal Borçlar', 'Ticari Borçlar'];

  // Geçmiş verilere dayalı bütçeleme modelini kullanan fonksiyon
  List<List<double>> butcelemeModeli() {
    final List<List<double>> veriler = [];

    // Varsayılan geçmiş veriler
    final List<double> gecmisVeriler = [500000, 550000, 605000, 665500, 732005]; // Basit bir yıllık %10 artış örneği

    // Büyüme oranları
    const double buyumeOraniVarliklar = 0.1;
    const double buyumeOraniBorclar = 0.08;
    const double buyumeOraniOzkaynaklar = 0.12;

    // Varlıklar (assets) verileri
    for (int i = 0; i < varliklar.length - 1; i++) {
      final List<double> satir = [];
      for (int j = 0; j < yillar.length; j++) {
        double deger = gecmisVeriler[j] * pow(1 + buyumeOraniVarliklar, j);
        satir.add(deger);
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
        double deger = gecmisVeriler[j] * pow(1 + buyumeOraniBorclar, j);
        satir.add(deger);
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
        double deger = gecmisVeriler[j] * pow(1 + buyumeOraniOzkaynaklar, j);
        satir.add(deger);
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
    final List<List<double>> butceVeri = butcelemeModeli();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilanço Proforma', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleWdiget(),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 20,
          columns: [
            DataColumn(label: Text('')),
            ...yillar.map((yil) => DataColumn(label: Text(yil))),
          ],
          rows: [
            ...varliklar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...butceVeri[varliklar.indexOf(etiket)].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
            ...borclar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...butceVeri[borclar.indexOf(etiket) + varliklar.length - 1].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
            ...ozkaynaklar.map(
                  (etiket) => DataRow(
                cells: [
                  DataCell(Text(etiket)),
                  ...butceVeri[ozkaynaklar.indexOf(etiket) + varliklar.length + borclar.length - 2].map((deger) => DataCell(Text('₺${deger.toStringAsFixed(2)}'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
