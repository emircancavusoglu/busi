import 'package:busi/calculations/ratio_calculations.dart';
import 'package:busi/prototype/ratio_analysis_results_prototype.dart';
import 'package:busi/widget/alertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowRatioResults extends StatefulWidget {
  const ShowRatioResults({required this.value, required this.likidite,
    required this.cariOran, required this.netKarOran, super.key,
    this.stokDevirHizi, this.alacakDevirHizi, this.aktifDevirHizi,
    this.faaliyetKariOrani, this.brutKarOrani, this.netKarOrani,
    });
  final List<List<String>> value;
  final double? likidite;
  final double? cariOran;
  final double? netKarOran;
  final double? stokDevirHizi;
  final double? alacakDevirHizi;
  final double? aktifDevirHizi;
  final double? faaliyetKariOrani;
  final double? brutKarOrani;
  final double? netKarOrani;

  @override
  State<ShowRatioResults> createState() => _ShowRatioResultsState();
}

class _ShowRatioResultsState extends State<ShowRatioResults> {
  Future<void> saveResultsToFirestore() async {
    try{
      await FirebaseFirestore.instance.collection('bilanco').add({
        'Likidite': widget.likidite,
        'Cari Oran': widget.cariOran,
        'Net Kar Oran': widget.netKarOran,
        'Stok Devir Hızı' : widget.stokDevirHizi,
        'Alacak Devir Hızı' : widget.alacakDevirHizi,
        'timestamp': FieldValue.serverTimestamp(),
      });
      alertDialog(context, 'Başarılı', 'Oran analiziniz başarıyla kaydedildi');
    }
    catch(e){
      alertDialog(context, 'Hata', 'Veriler kaydedilirken bir hata oluştu $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: const FlexibleWdiget(),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Oran analizi sonuçları',style: TextStyle(
            color: Colors.white,),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text('Likidite Oranları',style: TextStyle(color: Colors.white,fontSize: 22),),
              const SizedBox(height: 5),
              Text('Duran / Dönen : ${widget.likidite?.toStringAsFixed(2)} ',style: const
              TextStyle(fontSize: 18,color: Colors.white),),
              Text( 'Cari Oran : ${widget.cariOran?.toStringAsFixed(2)}',style:
              const TextStyle(fontSize: 18, color: Colors.white),) ,
              Text( 'Nakit Oranı : ${widget.alacakDevirHizi?.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.white),) ,
              const SizedBox(height: 10),
              const Text('Faaliyet Oranları',style: TextStyle(color: Colors.white,fontSize: 22),),
              const SizedBox(height: 5,),
              Text( 'Stok Devir Hızı : ${widget.stokDevirHizi?.toStringAsFixed(2)}',style:
                const TextStyle(fontSize: 18, color: Colors.white),) ,
              Text( 'Alacak Devir Hızı : ${widget.alacakDevirHizi?.toStringAsFixed(2)}',style:
                const TextStyle(fontSize: 18, color: Colors.white),) ,
              const SizedBox(height: 10),
              Text( 'Brüt kar Oranı : ${widget.alacakDevirHizi?.toStringAsFixed(2)}',style:
                const TextStyle(fontSize: 18, color: Colors.white),) ,
              Text( 'Faaliyet Karı Oranı : ${widget.alacakDevirHizi?.toStringAsFixed(2)}',style:
                const TextStyle(fontSize: 18, color: Colors.white),) ,
              Text( 'Kaldıraç Oranı : ${widget.alacakDevirHizi?.toStringAsFixed(2)}',style:
                const TextStyle(fontSize: 18, color: Colors.white),) ,
              Text( 'Net Kar Oranı : ${widget.netKarOran?.toStringAsFixed(2)}',style:
              const TextStyle(fontSize: 18, color: Colors.white),) ,
            ],
          ),
        ),
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: saveResultsToFirestore,
      child: const Text("Kaydet"),),
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
