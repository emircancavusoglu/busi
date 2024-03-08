// //multiple excel sheet choose from phone
// //
// import 'dart:html';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
//
// class AnalysisView extends StatefulWidget {
//   const AnalysisView({Key? key}) : super(key: key);
//
//   @override
//   State<AnalysisView> createState() => _AnalysisViewState();
// }
//
// class _AnalysisViewState extends State<AnalysisView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Analiz"),),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {}, child: const Text("Geçmiş Analizlerim")),
//             const SizedBox(width: 20,),
//             ElevatedButton(onPressed: () async {
//               final FilePickerResult? result = await FilePicker.platform
//                   .pickFiles(
//                 type: FileType.custom,
//                 allowMultiple: true,
//                 allowedExtensions: ['xlsx'],
//               );
//             }, child: const Text("Excel ile aktar"))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  getMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
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
          // Ensure Text size with SizedBox
          SizedBox(
            width: double.infinity, // Expand to fill available space
            child: Text(
              "Seçilen Dosyalar",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10.0), // Add some spacing
          // Wrap ListView.builder with Expanded for flexibility
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getMultipleFile,
        label: const Text("Dosya Seç"),
      ),
    );
  }
}
