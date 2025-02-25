// import 'package:firebase_auth/firebase_auth.dart';
import 'package:aakar_ai/app/authentication/view/pages/login_page.dart';
import 'package:aakar_ai/app/home/view/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        }

        //user not logged in
        return const LoginPage();
      },
    );
  }
}
