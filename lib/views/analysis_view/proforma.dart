import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/consts/navigator.dart';
import 'package:busi/views/proforoma_table.dart';
import 'package:busi/views/show_ratio_analysis_results.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class Proforma_Analysis_View extends StatefulWidget {
  const Proforma_Analysis_View({super.key});

  @override
  State<Proforma_Analysis_View> createState() => Proforma_Analysis_ViewState();
}

class Proforma_Analysis_ViewState extends State<Proforma_Analysis_View> {
  List<File?> files = [];
  late List<List<String>> allData;
  late double? donenVarliklar;
  late double? duranVarliklar;
  double sonuc = 0;
  late double? kisaVadeliYukumlulukler;
  double sonuc2 = 0;
  late double? netSatislar;
  late double? netKar;
  double sonuc3 = 0;

  // List<int> findColumnIndexes(List<String> headerRow,
  //     List<String> dataNames) {
  //   List<int> indexes = [];
  //
  //   for (var name in dataNames) {
  //     int index = headerRow.indexOf(name);
  //     if (index != -1) {
  //       indexes.add(index);
  //     }
  //   }
  //   return indexes;
  // }
  Future<void> readExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    allData = [];
    excel.tables.forEach((sheetName, table) {
      for (final row in table!.rows) {
        allData.add(row.map((cell) => cell?.value.toString() ?? '').toList());
      }
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
            textButton(context),
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

  TextButton textButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (allData.isNotEmpty) {
          donenVarliklar =double.tryParse(allData[2][1]);
          duranVarliklar =double.tryParse(allData[14][1]);
          kisaVadeliYukumlulukler =double.tryParse(allData[32][1]);
          netSatislar = double.tryParse(allData[74][1]);
          netKar = double.tryParse(allData[68][1]);
          print(kisaVadeliYukumlulukler);
          sonuc = donenVarliklar!/duranVarliklar!;
          sonuc2 = donenVarliklar!/ kisaVadeliYukumlulukler!;
          sonuc3 = netKar!/netSatislar!;
          NavigateToWidget.navigateToScreen(context, ProformaTable(donenVarliklar: 50000, duranVarliklar: 50000, kisaVadeliYukumlulukler: 50000,
              netSatislar: 50000, netKar: 50000),);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Lütfen doğru dosya giriniz.'),),);
        }
      },
      child: const Text('Devam Et'),
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

        // Dönen ve duran varlıkların indekslerini bul
        // List<int> columnIndexes = findColumnIndexes(allData[0], ["Dönen Varlıklar", "Duran Varlıklar"]);

        // if (columnIndexes.length == 2) {
        //   double donenVarliklar = double.parse(allData[1][columnIndexes[0]]);
        //   double duranVarliklar = double.parse(allData[1][columnIndexes[1]]);
        //   double ratio = donenVarliklar / duranVarliklar;
        //   print('Dönen Varlıklar / Duran Varlıklar Oranı: $ratio');
        // } else {
        //   print('Dönen varlık veya duran varlık verileri bulunamadı.');
        // }
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
        title: const Text('Proformanızı Oluşturun',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.blue],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Bilanço Tablonuzu Yükleyin',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
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
