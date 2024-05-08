import 'dart:io';
import 'package:busi/calculations/ratio_calculations.dart';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/consts/navigator.dart';
import 'package:busi/views/show_ratio_analysis_results.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatioAnalysisView extends StatefulWidget {
  const RatioAnalysisView({Key? key}) : super(key: key);

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
                allData.length - 1,
                    (index) => DataRow(
                  cells: List.generate(
                    allData[index + 1].length,
                        (cellIndex) => DataCell(Text(allData[index + 1][cellIndex])),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (allData.isNotEmpty) {
                  Values(data: allData);
                  NavigateToWidget.navigateToScreen(context, ShowRatioResults(value: allData),);
                } else {
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
        return;
      } else {
        await readExcelFile(files[i]!);
      }
    }
  }

  Future<String?> checkBalanceSheet(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.indigo],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Bilanço Tablonuzu Yükleyin',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final selectedFiles = await getMultipleFile();
                    setState(() {
                      files = selectedFiles;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('En az 1 dosya seçiniz')));
                  }
                },
                icon: const Icon(Icons.file_upload),
                label: const Text(
                  'Dosya Seç (Excel)',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                ),
              ),),
              const SizedBox(width: 10,),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text(
                    'Geçmiş Analizlerim',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 5,
                  ),
                ),
              ),

            ],
            ),
            const SizedBox(height: 30),
            if (files.isNotEmpty) ...[
              const Text(
                'Seçilen Dosyalar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        title: Text(
                          files[index]!.path.split("/").last,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateFiles,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                ),
                child: const Text(
                  'Onayla',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
