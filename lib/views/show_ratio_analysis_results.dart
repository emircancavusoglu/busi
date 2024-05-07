import 'package:busi/calculations/ratio_calculations.dart';
import 'package:flutter/material.dart';
class ShowRatioResults extends StatefulWidget {
  const ShowRatioResults({required this.value, super.key});
  final List<List<String>> value;

  @override
  State<ShowRatioResults> createState() => _ShowRatioResultsState();
}

class _ShowRatioResultsState extends State<ShowRatioResults> {
  late Values values;
  @override
  void initState() {
    super.initState();
    values = Values(data: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oran analizi sonuçları'),
      ),
      body: Column(
        children: [
          for (final row in values.foundRows)
            Text(
              row.join(', '),
              style: const TextStyle(fontSize: 16),
            ),
        ],
      ),
    );
  }
}

class Values extends OranAnalizi {

  Values({required this.data}) {
    if (data.isNotEmpty && data.first.length >= 5) {
      // Search for all matching values
      for (final searchValue in value) {
        final rowIndex = data.indexWhere((row) => row.contains(searchValue));
        if (rowIndex != -1) {
          foundRows.add(data[rowIndex]);
        }
      }

      if (foundRows.isEmpty) {
        print('Hiçbiri (${value.join(', ')}) dosyada bulunamadı');
      }
    } else {
      print('Geçersiz veri');
    }
  }
  final List<List<String>> data;
  final List<String> value = ['Ticari Alacaklar', "Stoklar", "Duran Varlıklar",
    'Net Satışlar', "Dönen Varlıklar", "Diğer Alacaklar", "Kısa Vadeli Borçlar"];

  List<List<String>> foundRows = [];
}
