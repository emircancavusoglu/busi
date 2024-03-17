import 'package:busi/consts/signIn.dart';
import 'package:busi/views/main_page_view.dart';
import 'package:busi/widget/bottom_navigation_bar.dart'; // Assuming you're using provider for navigation
import 'package:flutter/material.dart';

import '../auth/google_sign_in.dart';
import '../consts/navigator.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final String username = 'userDeneme';

  @override
  Widget build(BuildContext context) {
    final signInSize = MediaQuery.of(context).size.width * 0.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('Welcome To BusiCount $username'),
      ),
      body: Center(
        child: Column( // Use Column for vertical layout
          mainAxisAlignment: MainAxisAlignment.center, // Center widgets vertically
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await signInWithGoogle();
                  // Navigate to MainPageView on successful sign-in
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPageView()),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                }
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
                    assetGoogle(), // Replace with your Google icon asset function
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
                ],
              ),
            ),
            const SizedBox(height: 20), // Add spacing between buttons
            TextButton( // Use TextButton for temporary button
              onPressed: () {
                NavigateToWidget.navigateToScreen(context, const MainPageView());
              },
              child: const Text('geçici buton'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:busi/consts/navigator.dart';
// import 'package:busi/views/main_page_view.dart';
// import 'package:flutter/material.dart';
//
// class LoginView extends StatelessWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(onPressed: (){
//           NavigateToWidget.navigateToScreen(context, const MainPageView());
//         }, child: const Text("Giriş Yap")),
//       ),
//     );
//   }
// }
