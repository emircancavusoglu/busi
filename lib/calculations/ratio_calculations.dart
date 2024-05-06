// class Values {
//   final List<List<String>> data;
//   final List<String> value = ['Ticari Alacaklar', "Stoklar", "Duran Varlıklar",
//     'Net Satışlar', "Dönen Varlıklar", "Diğer Alacaklar", "Kısa Vadeli Borçlar"];
//
//   Values(this.data) {
//     if (data.isNotEmpty && data.first.length >= 5) {
//       final foundRows = [];
//
//       // Search for all matching values
//       for (final searchValue in value) {
//         final rowIndex = data.indexWhere((row) => row.contains(searchValue));
//         if (rowIndex != -1) {
//           foundRows.add(data[rowIndex]);
//         }
//       }
//
//       if (foundRows.isNotEmpty) {
//         for (final row in foundRows) {
//           print(row);
//         }
//       } else {
//         print('Hiçbiri (${value.join(', ')}) dosyada bulunamadı');
//       }
//     } else {
//       print('Geçersiz veri');
//     }
//   }
// }
