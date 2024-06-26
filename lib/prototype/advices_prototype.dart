import 'package:busi/prototype/ratio_analysis_results_prototype.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdvicesPrototype extends StatelessWidget {
  const AdvicesPrototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ABC Şirketi İçin Tavsiyelerimiz',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleWdiget(),
        iconTheme: buildIconThemeData(),
      ),
      body: ContainerWidget(),
    );
  }

  IconThemeData buildIconThemeData() =>
      IconThemeData(color: Colors.white);
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.blueAccent], // Gradient renkleri burada belirlendi
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.record_voice_over_outlined, color: Colors.white,),
                ),
              ),
              SizedBox(height: 5.0),
              const Text(
                'Bulunduğunuz pazarın yapısı ve trend analiz çalışmalarımız:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                    color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 10.0),
              const Text(
                'Ana sektörünüz olan lokantacılık incelendiğinde, son bir yıllık '
                    'gelişim incelendiğinde %28 lik bir büyüme meydana gelmiştir (Enflasyon oranınına göre değerlendiriniz). Toplamda 45.000 lokanta hizmet vermekte ve'
                    'yapılan son anketler incelendiğinde organik ve sağlıklı ürünlerin trend kategpri olduğu görülmektedir.',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 20.0),
              const Text(
                'Oran analizleri ve şirket yapınıza göre kişiselleştirilmiş tavsiyeler:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 10.0),
              Text(
                'Şirketin likidite durumu oldukça iyi görünüyor. Bu durum, kısa vadeli borçlarını ödeyebilme yeteneğinin yüksek olduğunu gösterir. Ancak, fazla likidite tutmak yerine,'
                    ' fazladan likiditeyi yatırım yapmak veya borçları azaltmak için kullanmak daha verimli olabilir.  Şirketin faaliyet oranları genel olarak olumlu görünüyor, ancak stok devir hızını artırmak için stok yönetiminde iyileştirmeler yapılabilir. Ayrıca, alacak tahsilat sürelerini azaltmak için müşterilere yönelik daha etkili bir tahsilat politikası '
                    'oluşturulabilir.',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 4,),
              const Center(child: Text("Genel Eğiliminiz",
                style: TextStyle(color: Colors.white,),)),
              SizedBox(height: 10.0),
              Container(
                height: 300, // Grafik yüksekliği
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  series: <CartesianSeries>[
                    LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('Oca', 35),
                        SalesData('Şub', 30),
                        SalesData('Mar', 34),
                        SalesData('Nis', 32),
                        SalesData('May', 40),
                      ],

                      xValueMapper: (SalesData sales, _) => sales.month,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      name: '',
                      color: Colors.black,
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}
