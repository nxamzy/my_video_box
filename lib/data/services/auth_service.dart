import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hozirgi foydalanuvchini olish
  User? get currentUser => _auth.currentUser;

  // Tizimga kirish (Login)
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Login xatosi: ${e.toString()}");
      return null;
    }
  }

  // Ro'yxatdan o'tish (Sign Up) - Agar kerak bo'lsa
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Ro'yxatdan o'tishda xato: $e");
      return null;
    }
  }

  // Tizimdan chiqish
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
