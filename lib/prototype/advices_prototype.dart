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
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC,'
                    ' making it over 2000 years old.',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 20.0),
              const Text(
                'Stres testleri, iflas riski analizleri, oran analizleri ve şirket yapınıza göre kişiselleştirilmiş tavsiyeler:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              SizedBox(height: 10.0),
              Text(
                'Lorem Ipsum is simply dummy text of'
                    ' the printing and typesetting industry.'
                    ' Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type '
                    'specimen book.',
                style: TextStyle(fontSize: 16.0, color: Colors.white), // Metin rengi beyaza ayarlandı
              ),
              Center(child: const Text("Genel Eğiliminiz",
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
