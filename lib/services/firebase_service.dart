import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String text, String sender) async {
    await _firestore.collection('messages').add({
      'text': text,
      'sender': sender,
      'time': DateTime.now(),
    });
  }
}