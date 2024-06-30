import 'package:flutter/material.dart';
import 'advices_prototype.dart';
import '../consts/getMultipleFile.dart';

class Ratio_Results_Prototype extends StatelessWidget {
  const Ratio_Results_Prototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oran Analizi Sonuçları", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleWdiget(),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Likidite Oranları'),
                    _buildResultRow("Asit Test Oranı", "2.17"),
                    _buildResultRow("Cari Oran", "2.57"),
                    _buildResultRow("Nakit Oranı", "2.00"),
                    const SizedBox(height: 10),
                    _buildSectionTitle('Faaliyet Oranları'),
                    _buildResultRow("Stok Devir Hızı", "1.67"),
                    _buildResultRow("Stok Devretme Süresi", "1.79"),
                    _buildResultRow("Alacak Devretme Hızı", "2.01"),
                    _buildResultRow("Aktif Devir Hızı", "2.27"),
                    _buildResultRow("Alacakların Ortalama Tahsilat Süresi", "2.67"),
                    const SizedBox(height: 10),
                    _buildSectionTitle('Mali Yapı Oranları'),
                    _buildResultRow("Kaldıraç Oranı", "2.27"),
                    _buildResultRow("Kısa Vadeli Yabancı Kaynak Oranı", "2.21"),
                    _buildResultRow("Uzun Vadeli Yabancı Kaynak Oranı", "2.07"),
                    _buildResultRow("Özkaynaklar Oranı", "2.27"),
                    _buildResultRow("Yabancı Kaynakların ÖzKaynaklara Oranı", "2.10"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class FlexibleWdiget extends StatelessWidget {
  const FlexibleWdiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.blue],
        ),
      ),
    );
  }
}