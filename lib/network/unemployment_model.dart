class UnemploymentModel {

  UnemploymentModel({this.tPTIG08, this.tarih});

  UnemploymentModel.fromJson(Map<String, dynamic> json) {
    tPTIG08 = json['TP_TIG08'] as double?;
    tarih = json['Tarih']?.toString();
  }
  double? tPTIG08;
  String? tarih;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TP_TIG08'] = tPTIG08;
    data['Tarih'] = tarih;
    return data;
  }
}

