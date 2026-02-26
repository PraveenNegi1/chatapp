import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> register(String email, String password, String name) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection('users').doc(credential.user!.uid).set({
      "name": name,
      "email": email,
      "isOnline": true,
      "lastSeen": DateTime.now(),
    });

    return credential.user;
  }

  Future<User?> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}