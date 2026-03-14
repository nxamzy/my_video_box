import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VideoRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addVideo({
    required String title,
    required String filePath, // Tanlangan video fayli yo'li
    required String description,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("Tizimga kirmagansiz!");

    // 1. Videoni Firebase Storage'ga yuklash
    File file = File(filePath);
    String fileName = 'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
    
    // Yuklash jarayoni boshlanadi
    UploadTask uploadTask = _storage.ref().child(fileName).putFile(file);
    
    // Yuklanib bo'lishini kutamiz va linkni olamiz
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // 2. Olingan linkni Firestore'ga saqlash
    await _firestore.collection('videos').add({
      'title': title,
      'videoUrl': downloadUrl, // Endi bu internet linki (URL)
      'description': description,
      'authorId': uid,
      'createdAt': FieldValue.serverTimestamp(),
      'progress': 0.1, 
    });
  }
}