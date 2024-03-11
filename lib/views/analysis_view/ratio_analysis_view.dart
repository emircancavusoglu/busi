import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RatioAnalysisView extends StatefulWidget {
  RatioAnalysisView({super.key});

  @override
  State<RatioAnalysisView> createState() => _RatioAnalysisViewState();
}
class _RatioAnalysisViewState extends State<RatioAnalysisView> {
  // Future<void> getMultipleFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowedExtensions: ['xlsx']
  //   );
  //   if (result != null) {
  //     List<File?> file = result.paths.map((path) => File(path!)).toList();
  //     files = file;
  //     setState(() {});
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Please select at least 1 file'),
  //     ),);
  //   }
  // }
  List<File?> files = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oran Analizi"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left:10),
            child: Text('Lütfen bilanço tablonuzu yükleyiniz.', style: TextStyle(color: Colors.black, )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text('(Görüntü işleme haricindeki verilerinizi excel formatında yükleyiniz.)'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 20),
            child: Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Geçmiş Analizlerim")),
                const SizedBox(width: 30,),
                ElevatedButton(onPressed: () async{
                  try{
                    final selectedFiles = await getMultipleFile();
                    setState(() {
                      files = selectedFiles;
                    });
                  }
                  catch (e){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
                    Text('Lütfen en az 1 dosya seçiniz')));
                  }
                  }, child: Text("Excel'den Aktar")),
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
          ), // Add some spacing
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
        Padding(
          padding: const EdgeInsets.only(bottom: 250),
          child: Visibility(
              visible: files.isNotEmpty,
              child: ElevatedButton(onPressed: (){}, child: Text("Onayla"))),
        )
        ],
      ),
    );
  }
}
