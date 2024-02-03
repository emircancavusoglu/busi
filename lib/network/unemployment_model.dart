import 'package:busi/network/network_source.dart';
import 'package:dio/dio.dart';

class UnemployementModel {
  double? tPTIG08;
  String? tarih;

  UnemployementModel({this.tPTIG08, this.tarih});

  UnemployementModel.fromJson(Map<String, dynamic> json) {
    tPTIG08 = json['TP_TIG08'] as double?;
    tarih = json['Tarih']?.toString();
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TP_TIG08'] = this.tPTIG08;
    data['Tarih'] = this.tarih;
    return data;
  }
}

