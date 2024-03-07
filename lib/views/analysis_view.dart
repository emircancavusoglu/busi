import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({Key? key}) : super(key: key);

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analiz"),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){}, child: Text("Geçmiş Analizlerim")),
            SizedBox(width: 20,),
            ElevatedButton(onPressed: () async {
              final FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx'],
              );          }, child: const Text("Yeni Analiz Yap"))
          ],
        ),
      ),
    );
  }
}
