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
    sector = widget.sector;
    fetchSectorFromFirebase();
    fetchResultsFromFirebase().then((_) {
      // decideBySectorAndResults();
    });
  }

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
        likidite = userResults.data()?['Likidite'] as double?;
        cariOran = userResults.data()?['Cari Oran'] as double?;
        netKarOran = userResults.data()?['Net Kar Oran'] as double?;
        stokDevirHizi = userResults.data()?['Stok Devir Hızı'] as double?;
        alacakDevirHizi = userResults.data()?['Alacak Devir Hızı'] as double?;
        aktifDevirHizi = userResults.data()?['Aktif Devir Hızı'] as double?;
        faaliyetKariOrani = userResults.data()?['Faaliyet Kar Oranı'] as double?;
        brutKarOrani = userResults.data()?['Brüt Kar Oranı'] as double?;
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
            if (sector == 'Konaklama' && likidite != null && likidite! > 1.5 &&
                cariOran != null && cariOran! > 1.5) ...[
              const Text(AdvicesStructure.highResultsAccomadation),
            ],
            if (sector == 'Yiyecek' && likidite != null && likidite! > 1.5) ...[
              const Text("deneme"),
            ],
            if (sector == 'Yiyecek' && alacakDevirHizi != null && stokDevirHizi != null && aktifDevirHizi != null &&
                alacakDevirHizi! < 9 && stokDevirHizi! < 10 && aktifDevirHizi! < 2) ...[
              const Text(AdvicesStructure.lowTurnOverResultsFood)
            ],
            if (sector == 'Yiyecek' && likidite != null && likidite! < 1.5 && cariOran != null && cariOran! < 1.2) ...[
              const Text(AdvicesStructure.lowLiquitdyResultsFood)
            ] else ...[
              const Text('Değerleriniz normal.'),
            ],
          ],
        ),
      ),
    );
  }
}

class AdvicesStructure {
  static const String highLiquidtyResultsFood = "Değerleriniz oldukça yüksektir";
  static const String lowLiquitdyResultsFood = 'Artan likidite ihtiyacına yönelik önlemler alınmalıdır,'
      "örneğin alacakların tahsilat süreci iyileştirilmeli ya da stok yönetimi revize edilmelidir."
      'Durum kritik likidite sorunlarını işaret ediyor olabilir, kısa vadeli borçları ödemek için yeterli likiditeye sahip olunmalıdır.';

  static const String lowTurnOverResultsFood = 'Alacak tahsilat süreçleri iyileştirilmeli, likidite sorunları önlenmelidir. '
      'Varlıkların etkin kullanımı için işletme faaliyetleri optimize edilmeli ve verimlilik artırılmalıdır. '
      'Stok yönetimi revize edilmeli ve stok devir hızı artırılmalıdır, aksi halde stok maliyetleri artabilir.';

  static const lowBorrowingResultsFood = "Yüksek borçlanma oranları riskleri artırabilir, öz sermaye kullanımı artırılmalı"
      " ve borçlar azaltılmalıdır. Yüksek borçlanma oranları riskleri artırabilir,"
      " alternatif finansman kaynakları araştırılmalı"
      " ve borçların azaltılması hedeflenmelidir. Öz sermaye düşük, bu durumda sermaye "
      "yapısı gözden geçirilmeli ve öz sermaye artırılmalıdır.";

  static const String highResultsAccomadation = "Yemek sektörüne göre "
      "değerleriniz oldukça yüksektir";
  static const String lowResultsAccomadation = "Konaklama sektörüne göre değerleriniz"
      " oldukça düşüktir";
}
