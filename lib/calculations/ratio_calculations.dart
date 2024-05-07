class OranAnalizi{
  OranAnalizi(){
    pasifler..addAll(kisaVadeYabanciKaynaklar)
    ..addAll(uzunVadeYabanciKaynaklar)
    ..addAll(ozKaynak);
    tumDegerler..addAll(aktifler)
    ..addAll(pasifler);
  }
  List<String> kisaVadeYabanciKaynaklar = ['Mali Borclar','Ticari Borclar',"Diger Borclar","Alinan Avanslar","Odenecek Vergi ve Yukumlulukler","Borc ve Gider Karşiliklari"
      'Gelecek Aylara Ait Gelirler ve Gider Tahakkuklari',
    "Diger Kisa Vadeli Yabanci Kaynaklar"];
  List<String> uzunVadeYabanciKaynaklar = ["Mali Borçlar","Ticari Borclar","Diger Borclar","Alinan Avanslar","Borc ve Gider Karsiliklari","Gelecek Yillara Ait Gelir ve Gider Kaynaklari",
    "Diger Uzun Vadeli Yabanci Kaynaklar"];
  List<String> ozKaynak = ["Odenmis Sermaye","Sermaye Yedekleri","Kar Yedekleri","Gecmis Yil Karlari","Donem Net Kari","Gecmis Yil Zararlari"];

  List<String> aktifler = [];
  List<String> pasifler = [];
  List<String> tumDegerler = [];

}
class LikiditeOranlari extends OranAnalizi{
  double? mevcutVarliklar;
  double? NakitVeNakitBenzeriVarliklar;
  double? PesinOlarakKolayliklaDonusturulebilenVarliklar;
  double? MevcutYukumlulukler;

  double? cariOran(){
    return mevcutVarliklar!/MevcutYukumlulukler!;
  }
  double? asitTestOrani(){
    return (NakitVeNakitBenzeriVarliklar!+PesinOlarakKolayliklaDonusturulebilenVarliklar!)/MevcutYukumlulukler!;
  }

  double? nakitOrani(){
    return NakitVeNakitBenzeriVarliklar!/MevcutYukumlulukler!;
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
    return satilanTicariMallarinMaliyeti!/ortalamaTicariMalStoku!;
  }
  double? stokDevretmeSuresi(){
    return 360/stokDevirSuresi!;
  }
  double? alacakDevretmeHizi(){
    return 360/stokDevirSuresi!;
  }
  double? AlacaklarinOrtalamaTahsilatSuresi(){
    return 360/alacakDevretmeHizi()!;
  }
  double? aktifDevirHizi(){
    return netSatislar!/aktifToplam!;
  }
  // void stokHesaplamaYazdir(){
  //   print(" Stokların bir yıl içinde kaç kez paraya"
  //       "dönüştürüldüğünü ifade eder " + "$stokDevirHizi()");
  // }
}

class MaliYapiOranlari extends OranAnalizi{
  double? toplamYabanciKaynaklar;
  double? pasifToplam;
  double? kisaVadeliYabanciKaynaklar;
  double? uzunVadeliYabanciKaynaklar;
  double? ozKaynaklar;

  double? kaldiracOrani(){
    return toplamYabanciKaynaklar!/pasifToplam!;
  }

  double? kisaVadeliYabanciKaynakOrani(){
    return toplamYabanciKaynaklar!/pasifToplam!;
  }

  double? uzunVadeliYabanciKaynakOrani(){
    return uzunVadeliYabanciKaynaklar!/pasifToplam!;
  }
  double? ozKaynaklarOrani(){
    return ozKaynaklar!/pasifToplam!;
  }

  double? yabanciKaynaklarinOzKaynaklaraOrani(){
    return toplamYabanciKaynaklar!/ozKaynaklar!;
  }

}

class KarlilikOranlari{
  double? brutSatisKari;
  double? netSatislar;
  double? faaliyetKari;
  double? donemKari;
  double? aktifToplam;
  double? ozKaynaklar;

  double? karlilik1(){
    return brutSatisKari!/netSatislar!;
  }
  double? karlilik2(){
    return faaliyetKari!/netSatislar!;
  }
  double? karlilik3(){
    return donemKari!/netSatislar!;

  }
  double? karlilik4(){
    return donemKari!/aktifToplam!;
  }
  double? karlilik5(){
    return donemKari!/ozKaynaklar!;
  }
}