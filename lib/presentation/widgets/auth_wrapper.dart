import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_folder_app/presentation/pages/main_pages/home_page.dart';
import 'package:my_folder_app/presentation/pages/sign_pages/signup.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Agar user kirgan bo'lsa, HomePage'ga o'tadi
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Agar user kirmagan bo'lsa, SignUp sahifasiga o'tadi
        return const SignUpPage();
      },
    );
  }
}
