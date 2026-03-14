import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Faqat Auth'ni tekshiramiz
    print("AUTH BOSHLANDI...");
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("AUTH BITDI! UID: ${userCredential.user?.uid}");

    // FIRESTORE QISMINI VAQTINCHALIK COMMENT QILIB TURAMIZ
    /*
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'email': email,
    });
    */
    print("HAMMASI TUGADI!");
  }

  // TIZIMGA KIRISH
  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // TIZIMDAN CHIQISH
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("SignOut xatosi: $e");
    }
  }

  // Hozirgi foydalanuvchi ismini olish
  String? getUserName() {
    return _auth.currentUser?.displayName;
  }
}
