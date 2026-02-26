import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PresenceService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void setOnline(bool status) {
    _firestore.collection("users").doc(_auth.currentUser!.uid).update({
      "isOnline": status,
      "lastSeen": DateTime.now(),
    });
  }
}