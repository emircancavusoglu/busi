import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/consts/navigator.dart';
import 'package:busi/views/analysis_view/analysis_types.dart';
import 'package:busi/views/show_ratio_analysis_results.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class RatioAnalysis extends StatefulWidget {
  const RatioAnalysis({super.key});

  @override
  State<RatioAnalysis> createState() => RatioAnalysisState();
}

class RatioAnalysisState extends State<RatioAnalysis> {
  List<File?> files = [];
  late List<List<String>> allData;
  late double? donenVarliklar;
  late double? duranVarliklar;
  late double? kisaVadeliYukumlulukler;
  late double? netSatislar;
  late double? netKar;
  late double? satislarinMaliyeti;
  late double? donemBasiStok;
  late double? donemSonuStok;
  late double? donemBasiTicariAlacaklar;
  late double? donemSonuTicariAlacaklar;
  late double? satisGelirleri;


  double ortalamaStok = 0;
  double likidite = 0;
  double cariOran = 0;
  double netKarOran = 0;
  double stokDevirHizi = 0;
  double ortalamaTicariAlacaklar = 0;
  double alacakDevirHizi = 0;

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
      satislarinMaliyeti = double.tryParse(allData[75][1]);
      donemBasiStok = double.tryParse(allData[9][4]);
      donemSonuStok = double.tryParse(allData[9][1]);
      donemBasiTicariAlacaklar = double.tryParse(allData[5][1]);
      donemSonuTicariAlacaklar = double.tryParse(allData[5][4]);
      satisGelirleri = double.tryParse(allData[74][1]);
      likidite = donenVarliklar!/duranVarliklar!;
      cariOran = donenVarliklar!/ kisaVadeliYukumlulukler!;
      netKarOran = netKar!/netSatislar!;
      ortalamaStok = (donemBasiStok! + donemSonuStok!) /2;
      stokDevirHizi = satislarinMaliyeti!/ ortalamaStok;
      ortalamaTicariAlacaklar = (donemBasiTicariAlacaklar! + donemSonuTicariAlacaklar!)/2;
      alacakDevirHizi = satisGelirleri!/ortalamaTicariAlacaklar;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lütfen doğru dosya giriniz.'),
      ));
    }
  }

  Future<void> validateFiles() async {
    for (final file in files) {
      await readExcelFile(file!);
    }
    if (allData.isNotEmpty) {
      // NavigateToWidget.navigateToScreen(context, ProformaTable(
      //   donenVarliklar: donenVarliklar!,
      //   duranVarliklar: duranVarliklar!,
      //   kisaVadeliYukumlulukler: kisaVadeliYukumlulukler!,
      //   netSatislar: netSatislar!,
      //   netKar: netKar!,
      // ),
      // );
      NavigateToWidget.navigateToScreen(
          context, ShowRatioResults(value: allData,
          likidite: likidite, cariOran: cariOran, netKarOran: netKarOran,
        stokDevirHizi: stokDevirHizi, alacakDevirHizi: alacakDevirHizi,
      ),);
    }
  }
  // Future<void> validateFiles() async {
  //   for (var i = 0; i < files.length; i++) {
  //     final message = await checkBalanceSheet(files[i]!);
  //   return;
  //   } else {
  //   await readExcelFile(files[i]!);
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              AnalysisTypes(),),);
        },
          icon: const Icon(Icons.chevron_left),),
        title: const Text('Oran Analizinizi Yapın',style: TextStyle(color: Colors.white),),
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
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight:
              FontWeight.bold),
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
