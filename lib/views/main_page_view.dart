// import 'package:busi/network/network_source.dart';
// import 'package:busi/network/unemployment_model.dart';
// import 'package:busi/views/favorites_view.dart';
// import 'package:busi/views/sector/sector_choose.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../widget/bottom_navigation_bar.dart';
//
// class MainPageView extends StatefulWidget {
//   const MainPageView({Key? key}) : super(key: key);
//
//   @override
//   State<MainPageView> createState() => _MainPageViewState();
// }
//
// class _MainPageViewState extends State<MainPageView> {
//   bool _isLoading = false;
//   void _changeLoading(){
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
//   Dio dio = Dio(BaseOptions(baseUrl: unemployment));
//   @override
//   void initState(){
//     super.initState();
//     fetchPostItems();
//   }
//   Future<void> fetchPostItems() async {
//     _changeLoading();
//     final response = await dio.get(unemployment);
//     if (response.statusCode == 200) {
//       final _datas = response.data;
//       if (_datas is List) {
//         setState(() {
//           _items = _datas
//               .map((e) => UnemploymentModel.fromJson(e as Map<String, dynamic>))
//               .toList();
//         });
//       }
//     }
//     _changeLoading();
//   }
//   List<UnemploymentModel>? _items;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: (){
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesView(),));
//         },icon: const Icon(Icons.favorite_border_outlined),),
//         ],
//       ),
//       body:
//       // ListView.builder(
//       //   itemCount: _items?.length ?? 0,
//       //   itemBuilder: (context, index) {
//       //   return ListTile(
//       //     title: Text(_items?[index].tarih ?? ''),
//       //     subtitle: Text('İşsizlik Verisi : ${_items?[index].tPTIG08}'),
//       //   );
//       // },),
//       bottomNavigationBar: const BottomNavigation(),
//     );
//   }
// }

import 'package:busi/views/analysis_view/analysis_types.dart';
import 'package:busi/views/analysis_view/ratio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final String giyimPerakende = "Giyim Perakendeciliği";
  final String konaklama = "Konaklama";
  final String yiyecek = "Yiyecek";

  Future<void> addSectorToFirestore(String sector) async {
    try {
      final String userId = GoogleAuthProvider().providerId; // Örnek kullanıcı kimliği

      // Kullanıcının zaten sektörü olup olmadığını kontrol et
      final docSnapshot = await FirebaseFirestore.instance
          .collection('userSectors')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        // Kullanıcı zaten bir sektör eklemişse, bir uyarı mesajı göster
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Sektör Zaten Eklenmiş'),
              content: const Text('Zaten bir sektör eklediniz.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    => const AnalysisTypes(),),);
                  },
                  child: const Text('Tamam'),
                ),
              ],
            );
          },
        );
      } else {
        // Kullanıcı sektörü eklememişse, sektörü ekleyin
        await FirebaseFirestore.instance.collection('userSectors').doc(userId).set({
          'sector': sector,
          'timestamp': FieldValue.serverTimestamp(), // Kayıt zamanı
        });

        // Firestore'a başarıyla eklendiğinde başarı sayfasına yönlendirme yap
        if (mounted) { // State'in hala aktif olup olmadığını kontrol edin
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RatioAnalysis()),
          );
        }
      }
    } catch (e) {
      print('Failed to add sector: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sektörünüzü Seçiniz',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: const GradientContainer(),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.blue],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildSectorButton(context, 'Konaklama'),
            _buildSectorButton(context, 'Yiyecek'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectorButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          addSectorToFirestore(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white70),
        ),
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.blueAccent],
        ),
      ),
    );
  }
}
