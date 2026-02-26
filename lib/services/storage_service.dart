import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    final ref = _storage
        .ref()
        .child("chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}