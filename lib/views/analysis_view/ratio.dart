import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/consts/navigator.dart';
import 'package:busi/views/proforoma_table.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class RatioAnalysisView extends StatefulWidget {
  const RatioAnalysisView({super.key});

  @override
  State<RatioAnalysisView> createState() => RatioAnalysisViewState();
}

class RatioAnalysisViewState extends State<RatioAnalysisView> {
  List<File?> files = [];
  late List<List<String>> allData;
  late double? donenVarliklar;
  late double? duranVarliklar;
  late double? kisaVadeliYukumlulukler;
  late double? netSatislar;
  late double? netKar;

  Future<void> readExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    allData = [];
    excel.tables.forEach((sheetName, table) {
      for (final row in table!.rows) {
        allData.add(row.map((cell) => cell?.value.toString() ?? '').toList());
      }
    });
    extractData();
  }

  void extractData() {
    if (allData.isNotEmpty) {
      donenVarliklar = double.tryParse(allData[2][1]);
      duranVarliklar = double.tryParse(allData[14][1]);
      kisaVadeliYukumlulukler = double.tryParse(allData[32][1]);
      netSatislar = double.tryParse(allData[74][1]);
      netKar = double.tryParse(allData[68][1]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lütfen doğru dosya giriniz.'),
      ));
    }
  }

  Future<void> validateFiles() async {
    for (var file in files) {
      await readExcelFile(file!);
    }
    if (allData.isNotEmpty) {
      NavigateToWidget.navigateToScreen(context, ProformaTable(
        donenVarliklar: donenVarliklar!,
        duranVarliklar: duranVarliklar!,
        kisaVadeliYukumlulukler: kisaVadeliYukumlulukler!,
        netSatislar: netSatislar!,
        netKar: netKar!,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finansal Tablolar'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            const Text(
              'Bilanço Tablonuzu Yükleyin',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 140,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            final selectedFiles = await getMultipleFile();
                            setState(() {
                              files = selectedFiles;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                'En az 1 dosya seçiniz'
                                ,),),);
                          }
                        },
                        icon: const Icon(Icons.file_upload),
                        label: const Text(
                          'Dosya Seç (Excel)',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor:
                        Colors.blueAccent, padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.blueAccent,
                          elevation: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 140,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.analytics_outlined),
                        label: const Text(
                          'Geçmiş Analizlerim',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.blueAccent,
                          elevation: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            const SizedBox(height: 10,),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text(
                'Kamera',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 15,),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.blueAccent,
                elevation: 5,
              ),
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
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
