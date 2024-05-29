class OranAnalizi{
  OranAnalizi(){
    pasifler..addAll(kisaVadeYabanciKaynaklar)
    ..addAll(uzunVadeYabanciKaynaklar)
    ..addAll(ozKaynak);
    aktifler..addAll(donenKaynaklar)
    ..addAll(duranKaynaklar);
    tumDegerler..addAll(aktifler)
    ..addAll(pasifler);
  }
  List<String> kisaVadeYabanciKaynaklar = ['Mali Borclar','Ticari Borclar','Diger Borclar',"Alinan Avanslar","Odenecek Vergi ve Yukumlulukler","Borc ve Gider Karşiliklari"
      'Gelecek Aylara Ait Gelirler ve Gider Tahakkuklari',
    "Diger Kisa Vadeli Yabanci Kaynaklar"];
  List<String> uzunVadeYabanciKaynaklar = ["Mali Borçlar","Ticari Borclar","Diger Borclar","Alinan Avanslar","Borc ve Gider Karsiliklari","Gelecek Yillara Ait Gelir ve Gider Kaynaklari",
    "Diger Uzun Vadeli Yabanci Kaynaklar"];
  List<String> ozKaynak = ["Odenmis Sermaye","Sermaye Yedekleri","Kar Yedekleri","Gecmis Yil Karlari","Donem Net Kari","Gecmis Yil Zararlari"];
  List<String> donenKaynaklar = ["Dönen Varlıklar","Nakit Ve Benzerleri","Kısa Vadeli Ticari Alacaklar","Stoklar","Diğer Dönen Varlıklar"];
  List<String> duranKaynaklar = ["Finansal Duran Varlıklar","Duran Varlıklar (Maddi ve Olmayan)","Diğer Duran Varlıklar"];

  List<String> aktifler = [];
  List<String> pasifler = [];
  List<String> tumDegerler = [];
}
class LikiditeOranlari extends OranAnalizi {
  double? mevcutVarliklar;
  double? NakitVeNakitBenzeriVarliklar;
  double? PesinOlarakKolayliklaDonusturulebilenVarliklar;
  double? MevcutYukumlulukler;
  double? donenVarliklar;
  double? duranVarliklar;

  double? deneme(){
    if(donenVarliklar!= null && duranVarliklar != null && duranVarliklar != 0){
      return donenVarliklar!/duranVarliklar!;
    }
    return null;
  }

  double? cariOran() {
    if (mevcutVarliklar != null && MevcutYukumlulukler != null && MevcutYukumlulukler != 0) {
      return mevcutVarliklar! / MevcutYukumlulukler!;
    } else {
      return null;
    }
  }

  double? asitTestOrani() {
    if (NakitVeNakitBenzeriVarliklar != null &&
        PesinOlarakKolayliklaDonusturulebilenVarliklar != null &&
        MevcutYukumlulukler != null &&
        MevcutYukumlulukler != 0) {
      return (NakitVeNakitBenzeriVarliklar! + PesinOlarakKolayliklaDonusturulebilenVarliklar!) / MevcutYukumlulukler!;
    } else {
      return null;
    }
  }

  double? nakitOrani() {
    if (NakitVeNakitBenzeriVarliklar != null && MevcutYukumlulukler != null && MevcutYukumlulukler != 0) {
      return NakitVeNakitBenzeriVarliklar! / MevcutYukumlulukler!;
    } else {
      return null;
    }
  }
}

class FaaliyetOranlari extends OranAnalizi{
  double? satilanTicariMallarinMaliyeti;
  double? ortalamaTicariMalStoku;
  double? stokDevirSuresi;
  double? netSatislar;
  double? aktifOrtalamaTicariAlacaklar;
  double? alacakDevirHizi;
  double? aktifToplam;

  double? stokDevirHizi(){
    if (satilanTicariMallarinMaliyeti != null && ortalamaTicariMalStoku != null && ortalamaTicariMalStoku != 0) {
      return satilanTicariMallarinMaliyeti! / ortalamaTicariMalStoku!;
    } else {
      return null;
    }
  }

  double? stokDevretmeSuresi(){
    if (stokDevirSuresi != null && stokDevirSuresi != 0) {
      return 360 / stokDevirSuresi!;
    } else {
      return null;
    }
  }

  double? alacakDevretmeHizi(){
    if (stokDevirSuresi != null && stokDevirSuresi != 0) {
      return 360 / stokDevirSuresi!;
    } else {
      return null;
    }
  }

  double? AlacaklarinOrtalamaTahsilatSuresi(){
    if (alacakDevirHizi != null && alacakDevirHizi != 0) {
      return 360 / alacakDevirHizi!;
    } else {
      return null;
    }
  }

  double? aktifDevirHizi(){
    if (netSatislar != null && aktifToplam != null && aktifToplam != 0) {
      return netSatislar! / aktifToplam!;
    } else {
      return null;
    }
  }
}

class MaliYapiOranlari extends OranAnalizi{
  double? toplamYabanciKaynaklar;
  double? pasifToplam;
  double? kisaVadeliYabanciKaynaklar;
  double? uzunVadeliYabanciKaynaklar;
  double? ozKaynaklar;

  // void setData(List<List<String>> data, Map<String, int>? columnNameMap) {
  //   if (columnNameMap != null) {
  //     toplamYabanciKaynaklar = double.tryParse(data[0][columnNameMap['Toplam Yabancı Kaynaklar']!]) ?? 0.0;
  //     pasifToplam = double.tryParse(data[0][columnNameMap['Pasif Toplam']!]) ?? 0.0;
  //     kisaVadeliYabanciKaynaklar = double.tryParse(data[0][columnNameMap['Kısa Vadeli Yabancı Kaynaklar']!]) ?? 0.0;
  //     uzunVadeliYabanciKaynaklar = double.tryParse(data[0][columnNameMap['Uzun Vadeli Yabancı Kaynaklar']!]) ?? 0.0;
  //     ozKaynaklar = double.tryParse(data[0][columnNameMap['Öz Kaynaklar']!]) ?? 0.0;
  //   } else {
  //     print('columnNameMap is null!');
  //   }
  // }

  double? kaldiracOrani(){
    if (toplamYabanciKaynaklar != null && pasifToplam != null && pasifToplam != 0) {
      return toplamYabanciKaynaklar! / pasifToplam!;
    } else {
      return null;
    }
  }

  double? kisaVadeliYabanciKaynakOrani(){
    if (toplamYabanciKaynaklar != null && pasifToplam != null && pasifToplam != 0) {
      return kisaVadeliYabanciKaynaklar! / pasifToplam!;
    } else {
      return null;
    }
  }
  double? uzunVadeliYabanciKaynakOrani(){
    if (uzunVadeliYabanciKaynaklar != null && pasifToplam != null && pasifToplam != 0) {
      return uzunVadeliYabanciKaynaklar! / pasifToplam!;
    } else {
      return null;
    }
  }

  double? ozKaynaklarOrani(){
    if (ozKaynaklar != null && pasifToplam != null && pasifToplam != 0) {
      return ozKaynaklar! / pasifToplam!;
    } else {
      return null;
    }
  }

  double? yabanciKaynaklarinOzKaynaklaraOrani(){
    if (toplamYabanciKaynaklar != null && ozKaynaklar != null && ozKaynaklar != 0) {
      return toplamYabanciKaynaklar! / ozKaynaklar!;
    } else {
      return null;
    }
  }
}

class KarlilikOranlari {
  double? brutSatisKari;
  double? netSatislar;
  double? faaliyetKari;
  double? donemKari;
  double? aktifToplam;
  double? ozKaynaklar;
  //
  // void setData(List<List<String>> data, Map<String, int>? columnNameMap) {
  //   if (columnNameMap != null && columnNameMap.isNotEmpty) {
  //     brutSatisKari = columnNameMap['Brüt Satış Karı'] != null ? double.tryParse(data[0][columnNameMap['Brüt Satış Karı']!] ?? '0') ?? 0.0 : null;
  //     netSatislar = columnNameMap['Net Satışlar'] != null ? double.tryParse(data[0][columnNameMap['Net Satışlar']!] ?? '0') ?? 0.0 : null;
  //     faaliyetKari = columnNameMap['Faaliyet Karı'] != null ? double.tryParse(data[0][columnNameMap['Faaliyet Karı']!] ?? '0') ?? 0.0 : null;
  //     donemKari = columnNameMap['Dönem Karı'] != null ? double.tryParse(data[0][columnNameMap['Dönem Karı']!] ?? '0') ?? 0.0 : null;
  //     aktifToplam = columnNameMap['Aktif Toplam'] != null ? double.tryParse(data[0][columnNameMap['Aktif Toplam']!] ?? '0') ?? 0.0 : null;
  //     ozKaynaklar = columnNameMap['Öz Kaynaklar'] != null ? double.tryParse(data[0][columnNameMap['Öz Kaynaklar']!] ?? '0') ?? 0.0 : null;
  //   } else {
  //     print('columnNameMap is null or empty!');
  //   }
  // }


  double? karlilik1() {
    if (brutSatisKari != null && netSatislar != null && netSatislar != 0) {
      return brutSatisKari! / netSatislar!;
    } else {
      return null;
    }
  }

  double? karlilik2() {
    if (faaliyetKari != null && netSatislar != null && netSatislar != 0) {
      return faaliyetKari! / netSatislar!;
    } else {
      return null;
    }
  }

  double? karlilik3() {
    if (donemKari != null && netSatislar != null && netSatislar != 0) {
      return donemKari! / netSatislar!;
    } else {
      return null;
    }
  }

  double? karlilik4() {
    if (donemKari != null && aktifToplam != null && aktifToplam != 0) {
      return donemKari! / aktifToplam!;
    } else {
      return null;
    }
  }

  double? karlilik5() {
    if (donemKari != null && ozKaynaklar != null && ozKaynaklar != 0) {
      return donemKari! / ozKaynaklar!;
    } else {
      return null;
    }
  }
}
