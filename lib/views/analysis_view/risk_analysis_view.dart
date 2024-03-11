import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RiskAnalysisView extends StatefulWidget {
  RiskAnalysisView({super.key});

  @override
  State<RiskAnalysisView> createState() => _RiskAnalysisViewState();
}

class _RiskAnalysisViewState extends State<RiskAnalysisView> {
  Future<void> getMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['xlsx']
    );
    if (result != null) {
      List<File?> file = result.paths.map((path) => File(path!)).toList();
      files = file;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select atleast 1 file'),
      ),);
    }
  }

  List<File?> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analiz"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Geçmiş Analizlerim")),
                const SizedBox(width: 30,),
                ElevatedButton(onPressed: getMultipleFile, child: const Text("Excel'den Aktar")),
              ],
            ),
          ),
          Visibility(
            visible: files.isNotEmpty,
            child: const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 10),
                child: Text(
                  "Seçilen Dosyalar",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0), // Add some spacing
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(files[index]!.path.split("/").last,
                      style: const TextStyle(color: Colors.black)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
