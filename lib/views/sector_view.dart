import 'package:flutter/material.dart';

class SectorView extends StatefulWidget {
  const SectorView({Key? key}) : super(key: key);

  @override
  State<SectorView> createState() => _SectorViewState();
}

class _SectorViewState extends State<SectorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sektör"),),
    );
  }
}
