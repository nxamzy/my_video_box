import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_folder_app/core/routes/platform_routes.dart';

class SignInPage extends StatefulWidget {
  final String? initialEmail;
  const SignInPage({super.key, this.initialEmail});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController; // <--- 'late' QILINDI
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    // SignUp'dan email kelgan bo'lsa, o'shani qo'yadi, bo'lmasa bo'sh bo'ladi
    _emailController = TextEditingController(text: widget.initialEmail ?? "");
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email va parolni kiriting!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted) {
        context.push(PlatformRoutes.homePage.route);
      }
    } on FirebaseAuthException catch (e) {
      String message = "Xatolik yuz berdi";
      if (e.code == 'user-not-found')
        message = "Bunday foydalanuvchi topilmadi.";
      if (e.code == 'wrong-password') message = "Parol noto'g'ri.";

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Xush kelibsiz! 👋",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              const Text(
                "Kvartira hisob-kitoblarini davom ettiramiz.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 50),

              // EMAIL INPUT
              _buildInputLabel("Email manzilingiz"),
              _buildTextField(
                _emailController,
                "example@mail.com",
                Icons.alternate_email,
              ),
              const SizedBox(height: 25),

              // PAROL INPUT
              _buildInputLabel("Parolingiz"),
              _buildTextField(
                _passwordController,
                "••••••••",
                Icons.lock_open_rounded,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Parolni unutdingizmi?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Kirish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Akkauntingiz yo'qmi?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(PlatformRoutes.signUpPage.route);
                    },
                    child: const Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        // PAROL BO'LSA VA KO'ZCHA BOSILMAGAN BO'LSA YASHIRADI
        obscureText: isPassword ? !_isPasswordVisible : false,
        // TELEFON XOTIRASIDAN EMAIL/PAROL TAKLIF QILISH
        autofillHints: isPassword
            ? [AutofillHints.password]
            : [AutofillHints.email],
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black54),
          // KO'ZCHA TUGMASI FAQAT PAROL UCHUN CHIQADI
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 15,
          ),
        ),
      ),
    );
  }
}
