import 'package:busi/calculations/ratio_calculations.dart';
import 'package:flutter/material.dart';

class ShowRatioResults extends StatefulWidget {
  const ShowRatioResults({required this.value, required this.sonuc, Key? key, this.sonuc2, this.sonuc3})
      : super(key: key);
  final List<List<String>> value;
  final double? sonuc;
  final double? sonuc2;
  final double? sonuc3;

  @override
  State<ShowRatioResults> createState() => _ShowRatioResultsState();
}

class _ShowRatioResultsState extends State<ShowRatioResults> {
  // late Values values;

  late LikiditeOranlari likiditeOranlari;
  late KarlilikOranlari karlilikOranlari;
  late double? donenVarliklar;
  late double? duranVarliklar;


  @override
  void initState() {
    super.initState();
    // Eğer widget.value null değilse values ve likiditeOranlari başlatılır
    if(widget.value != null) {
      // values = Values(data: widget.value);
      likiditeOranlari = LikiditeOranlari();
      // donenVarliklar ve duranVarliklar değişkenlerine verileri atayalım
      donenVarliklar = likiditeOranlari.donenVarliklar;
      duranVarliklar = likiditeOranlari.duranVarliklar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oran analizi sonuçları'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Text('Duran / Dönen : ${widget.sonuc?.toStringAsFixed(2)} ',style: const
            TextStyle(fontSize: 22),),
            Text( 'Cari Oran : ${widget.sonuc2?.toStringAsFixed(2)}',style:
            const TextStyle(fontSize: 22),) ,
            Text( 'Net Kar Oran : ${widget.sonuc3?.toStringAsFixed(2)}',style:
              const TextStyle(fontSize: 22),) ,
          ],
        ),
      ),
    );
  }
}

// class Values {
//   Values({required this.data}) {
//     if (data.isNotEmpty && data.first.length >= 5) {
//       for (final searchValue in value) {
//         final rowIndex = data.indexWhere((row) => row.contains(searchValue));
//         if (rowIndex != -1) {
//           foundRows.add(data[rowIndex]);
//         }
//       }
//       if (foundRows.isEmpty) {
//         print('Hiçbiri (${value.join(', ')}) dosyada bulunamadı');
//       }
//     } else {
//       print('Geçersiz veri');
//     }
//   }
//
//   final List<List<String>> data;
//   final List<String> value = [
//     'Ticari Alacaklar', "Stoklar", "Duran Varlıklar",
//     'Net Satışlar', "Dönen Varlıklar", "Diğer Alacaklar",
//     "Kısa Vadeli Borçlar", "Finansal Duran Varlıklar",
//     "Duran Varlıklar (Maddi ve Olmayan)",
//     "Diğer Duran Varlıklar", "Dönen Varlıklar",
//     "Nakit Ve Benzerleri", "Kısa Vadeli Ticari Alacaklar",
//     "Stoklar", "Diğer Dönen Varlıklar", "Odenmis Sermaye",
//     "Sermaye Yedekleri", "Kar Yedekleri", "Gecmis Yil Karlari",
//     "Donem Net Kari", "Gecmis Yil Zararlari", "Mali Borçlar",
//     "Ticari Borclar", "Diger Borclar", "Alinan Avanslar",
//     "Borc ve Gider Karsiliklari",
//     "Gelecek Yillara Ait Gelir ve Gider Kaynaklari",
//     "Diger Uzun Vadeli Yabanci Kaynaklar"
//   ];
//
//   List<List<String>> foundRows = [];
//
//   Map<String, int> get columnNameMap {
//     final map = <String, int>{};
//     if (data.isNotEmpty) {
//       for (int i = 0; i < data.first.length; i++) {
//         map[data.first[i]] = i;
//       }
//     }
//     return map;
//   }
// }
