import 'package:flutter/material.dart';

class SectorChoosePrototype extends StatelessWidget {
  const SectorChoosePrototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sektörünüzü Seçiniz",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: const GradientContainer(),
        iconTheme: IconThemeData(color: Colors.white),

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
            _buildSectorButton(context, "Gıda İmalatı"),
            _buildSectorButton(context, "Tekstil İmalatı"),
            _buildSectorButton(context, "Giyim İmalatı"),
            _buildSectorButton(context, "Fabrikasyon ve Metal Ürünleri İmalatı"),
            _buildSectorButton(context, "Gıda Perakendeciliği"),
            _buildSectorButton(context, "Giyim Perakendeciliği"),
            _buildSectorButton(context, "Konaklama"),
            _buildSectorButton(context, "Yiyecek"),
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
          // Sector selection logic can be added here
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
  const GradientContainer({Key? key}) : super(key: key);

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
