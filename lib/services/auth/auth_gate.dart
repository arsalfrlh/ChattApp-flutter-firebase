import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) { //snapshot sama seperti index Grid/ListBuilder
            //jika user sudah login dan tidak perlu login kembali ketika buka app
            if (snapshot.hasData) {
              return HomePage();
            } else {
              //jika user belum login akan ke page login
              return LoginPage();
            }
          }),
    );
  }
}
