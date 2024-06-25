import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Advices extends StatefulWidget {
  final String userId;

  Advices({Key? key, required this.userId, required String sector}) : super(key: key);

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  String sector = "";

  @override
  void initState() {
    super.initState();
    fetchSectorFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // Return different views based on the sector value
    if (sector == 'Konaklama') {
      return AccommodationView();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Şirketiniz İçin Tavsiyelerimiz',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: buildIconThemeData(),
        ),
        body: ContainerWidget(),
      );
    }
  }

  IconThemeData buildIconThemeData() => const IconThemeData(color: Colors.white);

  Future<void> fetchSectorFromFirebase() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('userSectors')
        .doc(widget.userId)
        .get();
    setState(() {
      sector = userDoc['sector'] as String; // Update sector state with fetched value
    });
  }
}

class AccommodationView extends StatelessWidget {
  const AccommodationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konaklama Sektörü için Tavsiyeler"),
      ),
      body: Center(
        child: Text("Tavsiyeler burada olacak"), // Replace with specific advice widgets
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.blueAccent],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing widgets here
            ],
          ),
        ),
      ),
    );
  }
}
