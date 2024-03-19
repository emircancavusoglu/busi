import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RatioAnalysisView extends StatefulWidget {
  RatioAnalysisView({Key? key}) : super(key: key);

  @override
  State<RatioAnalysisView> createState() => _RatioAnalysisViewState();
}

class _RatioAnalysisViewState extends State<RatioAnalysisView> {
  List<File?> files = [];

  Future<void> readExcelFileFromUser() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      PlatformFile file = result.files.first;
      var bytes = await file.bytes;
      var excel = Excel.decodeBytes(bytes! as List<int>);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]?.maxColumns);
        print(excel.tables[table]?.maxRows);
        for (var row in excel.tables[table]!.rows) {
          print('$row');
        }
      }
    } else {
      // Kullanıcı dosya seçmedi
      print('Dosya seçilmedi.');
    }
  }

  Future<void> validateFiles() async {
    for (var i = 0; i < files.length; i++) {
      final message = await checkBalanceSheet(files[i]!);
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Dosya ${files[i]!.path.split("/").last} bir bilanço tablosu içermiyor: $message"),
        ),);
        return; // Dosya geçerli değilse, işlemi sonlandır
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Tüm dosyalar bilanço tablosu içeriyor. Onaylandı!'),
    ),);
    //onaylandıysa ne olacak ?

  }

  Future<String?> checkBalanceSheet(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);

      const targetSheetName = 'Bilanço Tablosu';

      if (!excel.tables.keys.contains(targetSheetName)) {
        return 'Bilanço tablosu içeren sayfa bulunamadı';
      }
      final table = excel.tables[targetSheetName]!;
      if (table.rows.isEmpty) {
        return "Bilanço tablosu boş";
      }

      final expectedHeaders = <String>['Varlıklar', 'Kısa Vadeli Yükümlülükler', 'Uzun Vadeli Yükümlülükler'];
      for (var header in expectedHeaders) {
        if (!table.rows[0].any((cell) => cell?.value.toString() == header)) {
          return 'Bilanço tablosunda beklenen başlık bulunamadı: $header';
        }
      }
      // Tüm kontrolleri başarıyla geçtiyse, dosya bir bilanço tablosu içeriyor
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oran Analizi'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text('Lütfen bilanço tablonuzu yükleyiniz.', style: TextStyle(color: Colors.black, )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text('(Görüntü işleme haricindeki verilerinizi excel formatında yükleyiniz.)'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20),
            child: Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Geçmiş Analizlerim')),
                const SizedBox(width: 30,),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final selectedFiles = await getMultipleFile();
                      setState(() {
                        files = selectedFiles;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen en az 1 dosya seçiniz')));
                    }
                  },
                  child: const Text("Excel'den Aktar"),
                ),
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
                  'Seçilen Dosyalar',
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
                  title: Text(
                    files[index]!.path.split("/").last,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 250),
            child: Visibility(
              visible: files.isNotEmpty,
              child: ElevatedButton(
                onPressed: validateFiles,
                child: const Text('Onayla'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
