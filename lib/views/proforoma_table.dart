import 'dart:math';
import 'package:flutter/material.dart';

class ProformaTable extends StatelessWidget {
  final double donenVarliklar;
  final double duranVarliklar;
  final double kisaVadeliYukumlulukler;
  final double netSatislar;
  final double netKar;

  ProformaTable({
    super.key,
    required this.donenVarliklar,
    required this.duranVarliklar,
    required this.kisaVadeliYukumlulukler,
    required this.netSatislar,
    required this.netKar,
  });

  final List<String> yillar = ['Yıl 1', 'Yıl 2', 'Yıl 3', 'Yıl 4', 'Yıl 5'];
  final List<String> varliklar = [
    'Dönen Varlıklar',
    'Nakit ve Benzerleri',
    'Kısa Vadeli Ticari Alacaklar',
    'Stoklar',
    'Diğer Dönen Varlıklar',
  ];
  final List<String> borclar = [
    'Kısa Vadeli Borçlar',
    'Finansal Borçlar',
    'Ticari Borçlar',
  ];
  final List<String> ozkaynaklar = [
    'Özkaynaklar',
  ];

  final double varlikBuyumeOrani = 0.10; // %10 büyüme
  final double borcBuyumeOrani = 0.08;   // %8 büyüme
  final double ozkaynakBuyumeOrani = 0.12; // %12 büyüme

  List<List<double>> formulluVeriUret() {
    final List<List<double>> veriler = [];
    final int yilSayisi = yillar.length;

    List<double> donenVarliklarListesi = List.generate(yilSayisi,
            (index) => donenVarliklar * pow(1 + varlikBuyumeOrani, index));
    List<double> duranVarliklarListesi = List.generate(yilSayisi,
            (index) => duranVarliklar * pow(1 + varlikBuyumeOrani, index));
    List<double> kisaVadeliBorclarListesi = List.generate(yilSayisi,
            (index) => kisaVadeliYukumlulukler * pow(1 + borcBuyumeOrani, index));
    List<double> ozkaynaklarListesi = List.generate(yilSayisi,
            (index) => (donenVarliklarListesi[index] + duranVarliklarListesi[index])
                - kisaVadeliBorclarListesi[index],);

    veriler.add(donenVarliklarListesi);
    veriler.add(duranVarliklarListesi);
    veriler.add(kisaVadeliBorclarListesi);
    veriler.add(ozkaynaklarListesi);

    return veriler;
  }

  @override
  Widget build(BuildContext context) {
    List<List<double>> veriler = formulluVeriUret();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proforma Tablolar'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Yıllar')),
            for (final yil in yillar) DataColumn(label: Text(yil)),
          ],
          rows: [
            _buildDataRow(varliklar[0], veriler[0]),
            _buildDataRow(varliklar[1], veriler[0]),
            _buildDataRow(varliklar[2], veriler[0]),
            _buildDataRow(varliklar[3], veriler[0]),
            _buildDataRow(varliklar[4], veriler[0]),
            _buildDataRow(borclar[0], veriler[2]),
            _buildDataRow(borclar[1], veriler[2]),
            _buildDataRow(borclar[2], veriler[2]),
            _buildDataRow(ozkaynaklar[0], veriler[3]),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String label, List<double> values) {
    return DataRow(
      cells: [
        DataCell(Text(label)),
        for (final value in values) DataCell(Text(value.toStringAsFixed(2))),
      ],
    );
  }
}
