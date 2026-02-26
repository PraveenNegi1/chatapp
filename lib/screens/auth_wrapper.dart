import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'register_screen.dart';   // or login_screen.dart - your choice

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

        // When logged in → go to HomeScreen (chat app user list)
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Not logged in → start with Register (your preference)
        return const RegisterScreen();
      },
    );
  }
}