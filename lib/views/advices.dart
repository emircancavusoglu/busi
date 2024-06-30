import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Advices extends StatefulWidget {
  const Advices({
    required this.sector,
    super.key,
  });

  final String sector;

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  String sector = "";
   String advice = '';

  double? likidite;
  double? cariOran;
  double? netKarOran;
  double? stokDevirHizi;
  double? alacakDevirHizi;
  double? aktifDevirHizi;
  double? faaliyetKariOrani;
  double? brutKarOrani;

  @override
  void initState() {
    super.initState();
    sector = sector;
    fetchSectorFromFirebase();
    fetchResultsFromFirebase().then((_) {
      // decideBySectorAndResults();
    });
  }

  // void decideBySectorAndResults() {
  //   if (cariOran != null && cariOran! == 1.2 && sector == 'Yiyecek') {
  //     if (mounted) {
  //       setState(() {
  //         advice = 'Artan likidite ihtiyacına yönelik önlemler alınmalıdır, '
  //             'örneğin alacakların tahsilat süreci iyileştirilmeli ya da stok '
  //             'yönetimi revize edilmelidir.';
  //       });
  //     }
  //   }
  //   if (sector == 'Yiyecek' && alacakDevirHizi != null &&
  //       stokDevirHizi != null && aktifDevirHizi != null &&
  //       alacakDevirHizi! < 9 && stokDevirHizi! < 10 &&
  //       aktifDevirHizi! < 2) {
  //     if (mounted) {
  //       setState(() {
  //         advice = 'Alacak tahsilat süreçleri iyileştirilmeli, likidite sorunları önlenmelidir. '
  //             'Varlıkların etkin kullanımı için işletme faaliyetleri optimize edilmeli ve verimlilik artırılmalıdır. '
  //             'Stok yönetimi revize edilmeli ve stok devir hızı artırılmalıdır, aksi halde stok maliyetleri artabilir.';
  //       });
  //     }
  //   } else {
  //     if (mounted) {
  //       setState(() {
  //         advice = 'Durumunuz oldukça iyi görünüyor';
  //       });
  //     }
  //   }
  // }

  Future<void> fetchSectorFromFirebase() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('userSectors')
        .doc('google.com')
        .get();
    if (mounted) {
      setState(() {
        sector = userDoc['sector'] as String;
      });
    }
  }

  Future<void> fetchResultsFromFirebase() async {
    var userResults = await FirebaseFirestore.instance
        .collection('bilanco')
        .doc('fHlFzgU70mt61wbAk8m2')
        .get();
    if (mounted) {
      setState(() {
        likidite = userResults['Likidite'] as double?;
        cariOran = userResults['Cari Oran'] as double?;
        netKarOran = userResults['Net Kar Oran'] as double?;
        stokDevirHizi = userResults['Stok Devir Hızı'] as double?;
        alacakDevirHizi = userResults['Alacak Devir Hızı'] as double?;
        aktifDevirHizi = userResults['Aktif Devir Hızı'] as double?;
        faaliyetKariOrani = userResults['Faaliyet Kar Oranı'] as double?;
        brutKarOrani = userResults['Brüt Kar Oranı'] as double?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$sector Sektörü için Tavsiyeler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sector == 'Konaklama' && likidite! > 1.5) ...[
              Text(advice),
            ] else if (sector == 'Yiyecek' && likidite! > 1.5) ...[
              const Text(AdvicesStructure.highResultsFood),
            ]
            else if (sector == 'Yiyecek' && likidite! < 1.5)...[
              const Text(AdvicesStructure.lowResultsFood)
    ]
          ],
        ),
      ),
    );
  }

  IconThemeData buildIconThemeData() => const IconThemeData(color: Colors.white);
}
class AdvicesStructure{
  static const String highResultsFood = "Değerleriniz oldukça yüksektir";
  static const String lowResultsFood = "Değerleriniz oldukça yüksektir";
  static const String highResultsAccomadation = "Yemek sektörüne göre "
      "değerleriniz oldukça yüksektir";
  static const String lowResultsAccomadation = "Konaklama sektörüne göre değerleriniz"
      " oldukça düşüktir";
}