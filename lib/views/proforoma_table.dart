import 'dart:math';
import 'package:flutter/material.dart';

class ProformaTable extends StatelessWidget {
  ProformaTable({
    required this.donenVarliklar, required this.duranVarliklar,
    required this.kisaVadeliYukumlulukler, required this.netSatislar,
    required this.netKar, required this.finansalBorclar, super.key,
  });

  final double donenVarliklar;
  final double duranVarliklar;
  final double kisaVadeliYukumlulukler;
  final double netSatislar;
  final double netKar;
  final double finansalBorclar;

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

  List<List<double>> formulluVeriUret() {
    final List<List<double>> veriler = [];
    final int yilSayisi = yillar.length;

    List<double> donenVarliklarListesi = List.generate(yilSayisi,
            (index) => donenVarliklar * pow(1 + donenVarliklar / 100, index));
    List<double> duranVarliklarListesi = List.generate(yilSayisi,
            (index) => duranVarliklar * pow(1 + duranVarliklar / 100, index));
    List<double> kisaVadeliBorclarListesi = List.generate(yilSayisi,
            (index) => kisaVadeliYukumlulukler * pow
              (1 + kisaVadeliYukumlulukler /100, index),);
    List<double> ozkaynaklarListesi = List.generate(yilSayisi,
          (index) => (donenVarliklarListesi[index] + duranVarliklarListesi[index])
          - kisaVadeliBorclarListesi[index],);

    veriler..add(donenVarliklarListesi)
      ..add(duranVarliklarListesi)
      ..add(kisaVadeliBorclarListesi)
      ..add(ozkaynaklarListesi);

    return veriler;
  }

  @override
  Widget build(BuildContext context) {
    final veriler = formulluVeriUret();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proforma Tablolar'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('Yıllar')),
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
