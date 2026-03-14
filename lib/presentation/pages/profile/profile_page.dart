import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_folder_app/core/routes/platform_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  // Tizimdan chiqish funksiyasi
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      context.go(PlatformRoutes.signInPage.route); // Login sahifasiga qaytish
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // To'q fon
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAvatarSection(),
            const SizedBox(height: 20),

            // FOYDALANUVCHI MA'LUMOTLARI (Firebase'dan)
            Text(
              user?.displayName ?? "Foydalanuvchi",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user?.email ?? "email@example.com",
              style: TextStyle(color: Colors.blueGrey[300], fontSize: 14),
            ),

            const SizedBox(height: 35),
            _buildStatsRow(),

            const SizedBox(height: 40),
            _buildSectionHeader("MY VAULT", "Papkalarni boshqarish"),
            const SizedBox(height: 15),
            _buildVaultGrid(),

            const SizedBox(height: 40),
            _buildSectionHeader("SOZLAMALAR", ""),
            const SizedBox(height: 15),
            _buildSettingsList(),

            const SizedBox(height: 30),
            // CHIQISH TUGMASI
            _buildLogoutButton(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Profil",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.settings, color: Colors.white70),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF326CFE), Color(0xFF8E54FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF326CFE).withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundColor: const Color(0xFF1E293B),
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white24)
                  : null,
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF326CFE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("124", "DARSLAR"),
          _buildVerticalDivider(),
          _buildStatItem("8.2k", "BALLAR"),
          _buildVerticalDivider(),
          _buildStatItem("12", "SERTIFIKAT"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() =>
      Container(height: 30, width: 1, color: Colors.white10);

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: const TextStyle(
              color: Color(0xFF326CFE),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildVaultGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.4,
      children: [
        _buildVaultCard(
          "Cyber Security",
          "14 video",
          Icons.security,
          const Color(0xFF326CFE),
        ),
        _buildVaultCard(
          "AI Ethics",
          "8 video",
          Icons.psychology,
          const Color(0xFF10B981),
        ),
        _buildNewFolderCard(),
      ],
    );
  }

  Widget _buildVaultCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildNewFolderCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10, style: BorderStyle.solid),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_rounded, color: Colors.white38, size: 30),
          Text(
            "Yangi papka",
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Column(
      children: [
        _buildSettingsItem(
          Icons.history,
          "Ko'rishlar tarixi",
          Colors.orangeAccent,
        ),
        _buildSettingsItem(
          Icons.badge,
          "Mening yutuqlarim",
          Colors.purpleAccent,
        ),
        _buildSettingsItem(
          Icons.notifications_none,
          "Bildirishnomalar",
          Colors.blueAccent,
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white10,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: _signOut,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
        label: const Text(
          "Tizimdan chiqish",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
