import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Advices extends StatefulWidget {
  const Advices({
    required this.sector,
    super.key,
    this.likidite,
    this.cariOran,
    this.netKarOran,
    this.stokDevirHizi,
    this.alacakDevirHizi,
    this.aktifDevirHizi,
    this.faaliyetKariOrani,
    this.brutKarOrani,
    this.netKarOrani,
  });

  final String sector;
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
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  late String sector;
  late String advice = "";

  @override
  void initState() {
    super.initState();
    sector = widget.sector;
    fetchSectorFromFirebase();
    decideBySectorAndResults();
  }

  void decideBySectorAndResults() {
    if (widget.cariOran != null && widget.cariOran! < 1.2 && widget.sector == 'Yiyecek') {
      if (mounted) {
        setState(() {
          advice = 'Artan likidite ihtiyacına yönelik önlemler alınmalıdır, '
              'örneğin alacakların tahsilat süreci iyileştirilmeli ya da stok yönetimi revize edilmelidir.';
        });
      }
    }
    if (widget.sector == 'Yiyecek' && widget.alacakDevirHizi != null && widget.stokDevirHizi != null && widget.aktifDevirHizi != null &&
        widget.alacakDevirHizi! < 9 &&
        widget.stokDevirHizi! < 10 &&
        widget.aktifDevirHizi! < 2) {
      if (mounted) {
        setState(() {
          advice = 'Alacak tahsilat süreçleri iyileştirilmeli, likidite sorunları önlenmelidir. '
              'Varlıkların etkin kullanımı için işletme faaliyetleri optimize edilmeli ve verimlilik artırılmalıdır. '
              'Stok yönetimi revize edilmeli ve stok devir hızı artırılmalıdır, aksi halde stok maliyetleri artabilir.';
        });
      }
    } else {
      if (mounted) {
        setState(() {
          advice = "Durumunuz oldukça iyi görünüyor";
        });
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.sector} Sektörü için Tavsiyeler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sector == 'Konaklama') ...[
              const Text('Konaklama sektörü için tavsiyeler:'),
              Text(advice),
            ] else if (sector == 'Yiyecek') ...[
              const Text('Yiyecek sektörü için tavsiyeler:'),
              Text(advice),
            ],
            // Diğer sektörler için ek durumlar ekleyebilirsiniz
          ],
        ),
      ),
    );
  }

  IconThemeData buildIconThemeData() => const IconThemeData(color: Colors.white);
}

// class AccommodationView extends StatefulWidget {
//   const AccommodationView({super.key});
//
//   @override
//   State<AccommodationView> createState() => _AccommodationViewState();
// }
//
// class _AccommodationViewState extends State<AccommodationView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Konaklama Sektörü için Tavsiyeler'),
//       ),
//       body: const Center(
//         child: Text('Tavsiyeler burada olacak'),
//       ),
//     );
//   }
// }
//
// class FoodSector extends StatefulWidget {
//   const FoodSector({Key? key}) : super(key: key);
//
//   @override
//   State<FoodSector> createState() => _FoodSectorState();
// }
//
// class _FoodSectorState extends State<FoodSector> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Şirketinize Özgü Tavsiyeler'),
//       ),
//       body: Column(
//         children: [
//           Text("Yiyecek sektöründe, pazar hacmi .. seviyeye ulaşmıştır."),
//         ],
//       ),
//     );
//   }
// }
