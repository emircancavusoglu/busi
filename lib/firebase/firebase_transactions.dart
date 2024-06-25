

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseData{
  Future<String?> getUserSector() async {
    var snapshot = await FirebaseFirestore.instance.collection('userSectors')
        .doc('google.com').get();
    return snapshot.data()?['sector'] as String;
  }

}