import 'dart:io';
import 'package:busi/consts/getMultipleFile.dart';
import 'package:busi/consts/navigator.dart';
import 'package:busi/views/analysis_view/analysis_types.dart';
import 'package:busi/views/proforoma_table.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ProformaAnalysis extends StatefulWidget {
  const ProformaAnalysis({super.key});

  @override
  State<ProformaAnalysis> createState() => ProformaAnalysisState();
}

class ProformaAnalysisState extends State<ProformaAnalysis> {
  List<File?> files = [];
  late List<List<String>> allData;
   double? donenVarliklar;
  late double? duranVarliklar;
  late double? kisaVadeliYukumlulukler;
  late double? netSatislar;
  late double? netKar;
  // late double? finansalBorclar;
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
  } void calculateProforma() {
    List<double?> donenVarliklarList = [
      double.tryParse(allData[2][1]),
      double.tryParse(allData[2][2]),
      double.tryParse(allData[2][3]),
      double.tryParse(allData[2][4])
    ];
    List<double?> nakitVeBenzerleriList = [
      double.tryParse(allData[3][1]),
      double.tryParse(allData[3][2]),
      double.tryParse(allData[3][3]),
      double.tryParse(allData[3][4])
    ];
    List<double?> ticariAlacaklarList = [
      double.tryParse(allData[5][1]),
      double.tryParse(allData[5][2]),
      double.tryParse(allData[5][3]),
      double.tryParse(allData[5][4])
    ];
    List<double?> stoklarList = [
      double.tryParse(allData[9][1]),
      double.tryParse(allData[9][2]),
      double.tryParse(allData[9][3]),
      double.tryParse(allData[9][4])
    ];
    List<double?> finansalBorclarList = [
      double.tryParse(allData[33][1]),
      double.tryParse(allData[33][2]),
      double.tryParse(allData[33][3]),
      double.tryParse(allData[33][4])
    ];

    List<double?> duranVarliklarList = [
      double.tryParse(allData[14][1]),
      double.tryParse(allData[14][2]),
      double.tryParse(allData[14][3]),
      double.tryParse(allData[14][4])
    ];

    List<double?> kisaVadeliYukumluluklerList = [
      double.tryParse(allData[32][1]),
      double.tryParse(allData[32][2]),
      double.tryParse(allData[32][3]),
      double.tryParse(allData[32][4])
    ];

    List<double?> netSatislarList = [
      double.tryParse(allData[74][1]),
      double.tryParse(allData[74][2]),
      double.tryParse(allData[74][3]),
      double.tryParse(allData[74][4])
    ];

    List<double?> netKarList = [
      double.tryParse(allData[68][1]),
      double.tryParse(allData[68][2]),
      double.tryParse(allData[68][3]),
      double.tryParse(allData[68][4])
    ];

    List<double?> calculatePercentageDifferences(List<double?> values) {
      List<double?> differences = [];
      for (int i = 0; i < values.length - 1; i++) {
        if (values[i] != null && values[i + 1] != null) {
          double difference = ((values[i + 1]! - values[i]!) / values[i]!) * 100;
          differences.add(difference);
        } else {
          differences.add(null);
        }
      }
      return differences;
    }

    double calculateAverage(List<double?> differences) {
      double sum = 0;
      int count = 0;
      for (var difference in differences) {
        if (difference != null) {
          sum += difference;
          count++;
        }
      }
      return count > 0 ? sum / count : 0;
    }

    final donenVarliklarDifferences = calculatePercentageDifferences(donenVarliklarList);
    final nakitVeBenzerleriDifferences = calculatePercentageDifferences(nakitVeBenzerleriList);
    final ticariAlacaklarDifferences = calculatePercentageDifferences(ticariAlacaklarList);
    final stoklarDifferences = calculatePercentageDifferences(stoklarList);
    final finansalBorclarDifferences = calculatePercentageDifferences(finansalBorclarList);
    final duranVarliklarDifferences = calculatePercentageDifferences(duranVarliklarList);
    final kisaVadeliYukumluluklerDifferences = calculatePercentageDifferences(kisaVadeliYukumluluklerList);
    final netSatislarDifferences = calculatePercentageDifferences(netSatislarList);
    final netKarDifferences = calculatePercentageDifferences(netKarList);

    final averageDonenVarliklar = calculateAverage(donenVarliklarDifferences);
    final averageNakitVeBenzerleri = calculateAverage(nakitVeBenzerleriDifferences);
    final averageTicariAlacaklar = calculateAverage(ticariAlacaklarDifferences);
    final averageStoklar = calculateAverage(stoklarDifferences);
    final averageFinansalBorclar = calculateAverage(finansalBorclarDifferences);
    final averageDuranVarliklar = calculateAverage(duranVarliklarDifferences);
    final averageKisaVadeliYukumlulukler = calculateAverage(kisaVadeliYukumluluklerDifferences);
    final averageNetSatislar = calculateAverage(netSatislarDifferences);
    final averageNetKar = calculateAverage(netKarDifferences);

    print('Dönen Varlıklar Yüzde Farkları: $donenVarliklarDifferences');
    print('Dönen Varlıklar Yüzde Farkları Ortalaması: $averageDonenVarliklar');
    print("Nakit ve Benzerleri Yüzde Farkları: $nakitVeBenzerleriDifferences");
    print("Nakit ve Benzerleri Yüzde Farkları Ortalaması: $averageNakitVeBenzerleri");
    print("Ticari Alacaklar Yüzde Farkları: $ticariAlacaklarDifferences");
    print("Ticari Alacaklar Yüzde Farkları Ortalaması: $averageTicariAlacaklar");
    print("Stoklar Yüzde Farkları: $stoklarDifferences");
    print("Stoklar Yüzde Farkları Ortalaması: $averageStoklar");
    print("Finansal Borçlar Yüzde Farkları: $finansalBorclarDifferences");
    print("Finansal Borçlar Yüzde Farkları Ortalaması: $averageFinansalBorclar");
    print("Duran Varlıklar Yüzde Farkları: $duranVarliklarDifferences");
    print("Duran Varlıklar Yüzde Farkları Ortalaması: $averageDuranVarliklar");
    print('Kısa Vadeli Yükümlülükler Yüzde Farkları: $kisaVadeliYukumluluklerDifferences');
    print("Kısa Vadeli Yükümlülükler Yüzde Farkları Ortalaması: $averageKisaVadeliYukumlulukler");
    print("Net Satışlar Yüzde Farkları: $netSatislarDifferences");
    print("Net Satışlar Yüzde Farkları Ortalaması: $averageNetSatislar");
    print("Net Kar Yüzde Farkları: $netKarDifferences");
    print("Net Kar Yüzde Farkları Ortalaması: $averageNetKar");

    double donenVarliklarProforma = donenVarliklarList.last! * (1 + averageDonenVarliklar / 100);
    double nakitVeBenzerleriProforma = nakitVeBenzerleriList.last! * (1 + averageNakitVeBenzerleri / 100);
    double ticariAlacaklarProforma = ticariAlacaklarList.last! * (1 + averageTicariAlacaklar / 100);
    double stoklarProforma = stoklarList.last! * (1 + averageStoklar / 100);
    double finansalBorclarProforma = finansalBorclarList.last! * (1 + averageFinansalBorclar / 100);
    double duranVarliklarProforma = duranVarliklarList.last! * (1 + averageDuranVarliklar / 100);
    double kisaVadeliYukumluluklerProforma = kisaVadeliYukumluluklerList.last! * (1 + averageKisaVadeliYukumlulukler / 100);
    double netSatislarProforma = netSatislarList.last! * (1 + averageNetSatislar / 100);
    double netKarProforma = netKarList.last! * (1 + averageNetKar / 100);

    print('Proforma Dönen Varlıklar: $donenVarliklarProforma');
    print("Proforma Nakit ve Benzerleri: $nakitVeBenzerleriProforma");
    print("Proforma Ticari Alacaklar: $ticariAlacaklarProforma");
    print("Proforma Stoklar: $stoklarProforma");
    print("Proforma Finansal Borçlar: $finansalBorclarProforma");
    print("Proforma Duran Varlıklar: $duranVarliklarProforma");
    print("Proforma Kısa Vadeli Yükümlülükler: $kisaVadeliYukumluluklerProforma");
    print("Proforma Net Satışlar: $netSatislarProforma");
    print("Proforma Net Kar: $netKarProforma");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProformaTable(
          donenVarliklar: donenVarliklarProforma,
          // nakitVeBenzerleriProforma: nakitVeBenzerleriProforma,
          // ticariAlacaklarProforma: ticariAlacaklarProforma,
          // stoklarProforma: stoklarProforma,
          finansalBorclar: finansalBorclarProforma,
          duranVarliklar: duranVarliklarProforma,
          kisaVadeliYukumlulukler: kisaVadeliYukumluluklerProforma,
          netSatislar: netSatislarProforma,
          netKar: netKarProforma,
        ),
      ),
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
          NavigateToWidget.navigateToScreen(context, ProformaTable(
              donenVarliklar: donenVarliklar!,
              duranVarliklar: duranVarliklar!,
            kisaVadeliYukumlulukler: kisaVadeliYukumlulukler!,
              netSatislar: netSatislar!, netKar: netKar!, finansalBorclar: 1,
            // finansalBorclar: finansalBorclar!,
          ),);
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
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              AnalysisTypes(),),);
        },
          icon: const Icon(Icons.chevron_left),),
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
