import 'package:busi/views/login_view.dart';
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
    const PageOne(),
    const PageTwo(),
    const PageThree()
  ];
  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  @override
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
    return SizedBox(
        child: Image.asset('assets/introduction.png',fit: BoxFit.scaleDown,),
    );
  }
}
class PageTwo extends StatelessWidget{
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset('assets/introduction-1.png',fit: BoxFit.scaleDown,),
    );
  }
}
class PageThree extends StatelessWidget {
  const PageThree({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child:
                Image.asset('assets/introduction-2.png',fit: BoxFit.scaleDown,),
          ),
          Positioned(
            bottom: 60,
            right: 10,
            child: SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => LoginView(),),);
                },
                child: const Icon(Icons.forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



