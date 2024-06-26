import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Advices extends StatefulWidget {
  final String sector;

  const Advices({Key? key, required this.sector}) : super(key: key);

  @override
  State<Advices> createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  late String sector;

  @override
  void initState() {
    super.initState();
    sector = widget.sector;
    fetchSectorFromFirebase();
  }

  Future<void> fetchSectorFromFirebase() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('userSectors')
        .doc('google.com')
        .get();
    setState(() {
      sector = userDoc['sector'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sector == 'Konaklama') {
      return const AccommodationView();
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
        body: const ContainerWidget(),
      );
    }
  }

  IconThemeData buildIconThemeData() => const IconThemeData(color: Colors.white);
}

class AccommodationView extends StatefulWidget {
  const AccommodationView({super.key});

  @override
  State<AccommodationView> createState() => _AccommodationViewState();
}

class _AccommodationViewState extends State<AccommodationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konaklama Sektörü için Tavsiyeler'),
      ),
      body: const Center(
        child: Text('Tavsiyeler burada olacak'),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

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
