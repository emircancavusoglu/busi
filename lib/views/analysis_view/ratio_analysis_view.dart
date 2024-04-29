import 'dart:io';
import 'package:busi/calculations/ratio_calculations.dart';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/views/show_ratio_analysis_results.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RatioAnalysisView extends StatefulWidget {
  const RatioAnalysisView({super.key});

  @override
  State<RatioAnalysisView> createState() => RatioAnalysisViewState();
}

class RatioAnalysisViewState extends State<RatioAnalysisView> {
  List<File?> files = [];
  late List<List<String>> allData;

  Future<void> readExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    allData = [];

    // Tüm sayfalardaki veri hücrelerini al
    excel.tables.forEach((sheetName, table) {
      table!.rows.forEach((row) {
        allData.add(row.map((cell) => cell?.value.toString() ?? '').toList());
      });
    });
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bilanço Verileriniz'),
          content: SingleChildScrollView(
            child: DataTable(
              columns: List.generate(
                allData.isNotEmpty ? allData[0].length : 0,
                    (index) => DataColumn(label: Text('Satır Adı ${index + 1}')),
              ),
              rows: List.generate(
                allData.length - 1, // İlk satır başlık olduğu için -1
                    (index) => DataRow(
                  cells: List.generate(
                    allData[index + 1].length, // İlk satır başlık olduğu için +1
                        (cellIndex) => DataCell(Text(allData[index + 1][cellIndex])),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if(allData.isNotEmpty){
                  Values(allData);
                  Navigator.pushReplacement(context, const ShowRatioResults()
                  as Route<Object?>);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lütfen doğru dosya giriniz.")));
                }
                },
              child: const Text('Devam Et'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }


Future<void> validateFiles() async {
    for (var i = 0; i < files.length; i++) {
      final message = await checkBalanceSheet(files[i]!);
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Dosya ${files[i]!.path.split("/").last} bir bilanço tablosu içermiyor: $message"),
        ));
        return; // Dosya geçerli değilse, işlemi sonlandır
      } else {
        // Dosya geçerliyse, içeriği ekrana bas
        await readExcelFile(files[i]!);
      }
    }
  }

  Future<String?> checkBalanceSheet(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);

      // Tüm kontrolleri geçtikten sonra hiçbir uyarı mesajı döndürme
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
            child: Text(
              'Lütfen bilanço tablonuzu yükleyiniz.',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text('(Görüntü işleme haricindeki verilerinizi excel formatında yükleyiniz.)'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Geçmiş Analizlerim'),
                ),
                const SizedBox(width: 30),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
