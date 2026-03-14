import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildAvatarSection(),
            const SizedBox(height: 15),
            const Text(
              "Alex Rivera, PhD",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Senior Learning Specialist",
              style: TextStyle(color: Colors.white38, fontSize: 14),
            ),
            const SizedBox(height: 30),
            _buildStatsRow(),
            const SizedBox(height: 40),
            _buildSectionHeader("MY VAULT", "Manage Folders"),
            const SizedBox(height: 15),
            _buildVaultGrid(),
            const SizedBox(height: 40),
            _buildSectionHeader("PERSONAL LEARNING", ""),
            const SizedBox(height: 15),
            _buildLearningList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
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
              border: Border.all(color: const Color(0xFF326CFE), width: 2),
            ),
            child: const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF326CFE),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem("124", "LESSONS"),
        _buildVerticalDivider(),
        _buildStatItem("8.2k", "POINTS"),
        _buildVerticalDivider(),
        _buildStatItem("12", "CERTIFICATES"),
      ],
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

  Widget _buildVerticalDivider() {
    return Container(height: 30, width: 1, color: Colors.white10);
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: const TextStyle(color: Color(0xFF326CFE), fontSize: 12),
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
      childAspectRatio: 1.3,
      children: [
        _buildVaultCard(
          "Cyber Defense",
          "14 saved videos",
          Icons.shield,
          const Color(0xFF326CFE),
        ),
        _buildVaultCard(
          "AI Ethics",
          "8 saved videos",
          Icons.psychology,
          const Color(0xFF10B981),
        ),
        _buildVaultCard(
          "Market Analysis",
          "22 saved videos",
          Icons.bar_chart,
          const Color(0xFFF59E0B),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Colors.white38, size: 30),
          SizedBox(height: 8),
          Text(
            "New Folder",
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningList() {
    return Column(
      children: [
        _buildListItem(Icons.history, "Watch History"),
        _buildListItem(Icons.badge, "My Certificates"),
        _buildListItem(Icons.payments, "Subscriptions"),
      ],
    );
  }

  Widget _buildListItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 22),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}
