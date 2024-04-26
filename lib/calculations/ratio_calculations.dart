import 'package:busi/firebase_options.dart';
import 'package:busi/views/analysis_view/ratio_analysis_view.dart';
import 'package:firebase_core/firebase_core.dart';


class SayStocks {
  final List<List<String>> data;

  SayStocks(this.data) {
    if (data.isNotEmpty && data.first.length >= 5) {
      int rowIndex = data.indexWhere((row) => row.contains('Stoklar'));

      if (rowIndex != -1) {
        // Print the row containing "Stoklar"
        print(data[rowIndex]);
      } else {
        print('Stoklar başlığı dosyada bulunamadı');
      }
    } else {
      print('Geçersiz veri');
    }
  }
}


