import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_folder_app/core/routes/platform_routes.dart';
import 'package:my_folder_app/data/repositories/auth_repositories.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthRepository _authRepository = AuthRepository(); // Obyekt olamiz
  // RO'YXATDAN O'TISH FUNKSIYASI
  // RO'YXATDAN O'TISH FUNKSIYASI
  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Validatsiya (Bo'sh maydonlarni tekshirish)
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Iltimos, barcha maydonlarni to'ldiring!"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. Repository orqali ro'yxatdan o'tkazamiz
      await _authRepository.signUpUser(
        name: name,
        email: email,
        password: password,
      );

      // 3. Muvaffaqiyatli bo'lsa, HomePage'ga o'tamiz
      if (mounted) {
        context.push(PlatformRoutes.homePage.route);
      }
    } on FirebaseAuthException catch (e) {
      // Firebase xatolarini ushlash
      String message = "Xatolik yuz berdi";
      if (e.code == 'email-already-in-use') message = "Bu email band.";
      if (e.code == 'weak-password') message = "Parol juda zaif.";
      if (e.code == 'invalid-email') message = "Email manzili noto'g'ri.";

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      // 🔥 ENG MUHIMI: Kutilmagan boshqa har qanday xatoni ushlash
      // Bu qism bo'lmasa, xato chiqsa _isLoading false bo'lmay qoladi
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kutilmagan xato: ${e.toString()}")),
        );
      }
    } finally {
      // 🔥 Har qanday holatda ham (xato bo'lsa ham, bo'lmasa ham) loadingni o'chirish
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ro'yxatdan o'tish 📝",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "KV App'ga xush kelibsiz!",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 50),

              // ISM INPUT
              _buildTextField(
                _nameController,
                "Ismingiz",
                Icons.person_outline,
              ),
              const SizedBox(height: 20),

              // EMAIL INPUT
              _buildTextField(_emailController, "Email", Icons.email_outlined),
              const SizedBox(height: 20),

              // PAROL INPUT
              _buildTextField(
                _passwordController,
                "Parol",
                Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 40),

              // SIGN UP TUGMASI
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Akkauntingiz bormi? Kirish",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
