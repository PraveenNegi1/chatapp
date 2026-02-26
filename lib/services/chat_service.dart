import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String createRoomId(String uid1, String uid2) {
    return uid1.hashCode <= uid2.hashCode
        ? "$uid1\_$uid2"
        : "$uid2\_$uid1";
  }

  Stream<QuerySnapshot> getMessages(String roomId) {
    return _firestore
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      String roomId, String text, String? imageUrl) async {
    await _firestore
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .add({
      "text": text,
      "imageUrl": imageUrl,
      "senderId": _auth.currentUser!.uid,
      "timestamp": DateTime.now(),
    });
  }
}