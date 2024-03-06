import 'package:busi/consts/signIn.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:busi/widget/bottom_navigation_bar.dart';
import '../auth/google_sign_in.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final String username = 'userDeneme';

  @override
  Widget build(BuildContext context) {
    final signInSize = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Welcome To BusiCount $username'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await signInWithGoogle();
              // navigator
            } catch (error) {
              Text("$error");
            }
            //navigator
            },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(300, 60),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetGoogle(),
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Google ile Giriş Yap',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ElevatedButton(onPressed: (){
              NavigateToWidget.navigateToScreen(context, const MainPageView());
            },child: const Text("geçici buton"))
            ],
          ),
        ),

      )
    );
  }
}
