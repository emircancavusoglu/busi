import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [
    PageOne(),
    PageTwo(),
    PageThree()
  ];
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  void dispose (){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page){
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
            return _pages[index % _pages.length];
          },),
          Positioned(
            bottom: 0,
            left: 0,
            height: 50,
            child: Container(
              width: screenWidth,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                  List<Widget>.generate(
                    _pages.length, (index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(
                    horizontal: 10,),
                  child: InkWell(
                    onTap: (){
                      _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,);
                      },
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: _activePage == index
                          ? Colors.red:
                          Colors.white,
                    ),
                  ),
                  ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget{
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Introduce of BusiCount"),
      ],
      ),
    );
  }
}
class PageTwo extends StatelessWidget{
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Introduce of BusiCount"),
      ],
      ),
    );
  }
}
class PageThree extends StatelessWidget{
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Introduce of BusiCount"),
      ],
      ),
    );
  }
}
