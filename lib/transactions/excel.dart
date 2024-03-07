// import 'dart:io';
//
// import 'package:excel/excel.dart';
//
// void main() {
//   // Excel dosyasını oku
//   var bytes = File('muhasebe_kayitlari.xlsx').readAsBytesSync();
//   var excel = Excel.decodeBytes(bytes);
//
//   // İlk çalışma sayfasını al
//   var sheet = excel['Sheet1'];
//
//   // Verileri depolamak için bir liste oluştur
//   List<List<dynamic>> data = [];
//
//   // Excel sayfasındaki hücreleri oku ve veri listesine ekle
//   for (var row in sheet.rows) {
//     List<dynamic> rowData = [];
//     for (var cell in row) {
//       rowData.add(cell?.value);
//     }
//     data.add(rowData);
//   }
//
//   // Veri listesini kullanarak istediğiniz hesaplamaları yapabilirsiniz
//   // Örneğin, toplam geliri hesaplamak için
//   double toplamGelir = 0;
//   for (var row in data) {
//     toplamGelir += double.parse(row[1]); // 1. sütundaki geliri topla
//   }
//   print('Toplam Gelir: $toplamGelir');
//
//   // Hesaplamaları başka bir Excel dosyasına yazabilirsiniz
//   var newExcel = Excel.createExcel();
//   var newSheet = newExcel['Sheet1'];
//   newSheet.appendRow(['Toplam Gelir', toplamGelir]);
//
//   // Yeni Excel dosyasını oluştur
//   var file = File('yeni_muhasebe_kayitlari.xlsx');
//   file.writeAsBytesSync(newExcel.encode());
// }
//
