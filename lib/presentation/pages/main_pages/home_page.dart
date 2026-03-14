import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_folder_app/core/routes/platform_routes.dart';
import 'package:my_folder_app/presentation/pages/add_pages/add_video_page.dart';
import 'package:my_folder_app/presentation/pages/main_pages/library_page.dart';
import 'package:my_folder_app/presentation/pages/main_pages/profile_page.dart';
import 'package:my_folder_app/presentation/pages/main_pages/topic_page.dart';
import 'package:my_folder_app/presentation/pages/video_player_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;
  String userName = "Student";

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? user.email?.split('@')[0] ?? "Student";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      _buildHomeTab(),
      const TopicPage(),
      const AddVideoPage(),
      const MyCourseLibrary(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      title: 'Home',
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.grid_view),
      title: 'Topics',
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add, color: Colors.white),
      title: 'Add',
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.play_lesson_outlined),
      title: 'Library',
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: 'Profile',
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: const Color(0xFF262A35),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        colorBehindNavBar: Color(0xff101622),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }

  Widget _buildHomeTab() => Scaffold(
    backgroundColor: const Color(0xff101622),
    appBar: AppBar(
      backgroundColor: const Color(0xff101622),
      leadingWidth: 0,
      titleSpacing: 20,
      title: Row(
        children: [
          InkWell(
            onTap: () => context.push(PlatformRoutes.profilePage.route),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF5474FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school, size: 20, color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "Learning Hub",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.bell, color: Colors.white),
        ),
        const SizedBox(width: 10),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Good Evening,",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5474FF),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Ready to continue your streak?",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 25),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip("Cyber Security", true, Icons.security),
                _buildCategoryChip("UX Design", false, null),
                _buildCategoryChip("Python", false, null),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // DINAMIK QISM: Barcha videolar bazadan keladi
          _buildProgressSection(),

          const SizedBox(height: 30),
          const Text(
            "For Your Growth",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildGrowthCard(),
          const SizedBox(height: 100),
        ],
      ),
    ),
  );

  Widget _buildProgressSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Lessons",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "See All",
                style: TextStyle(color: Color(0xFF5474FF)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('videos')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(color: Colors.white),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "No videos found",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }

            final videos = snapshot.data!.docs;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: videos.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                // MANA SHU YERDAN BOSHLAB O'ZGARTIRILDI:
                final video = videos[index].data() as Map<String, dynamic>;
                final url = video['videoUrl'] ?? "";

                return GestureDetector(
                  onTap: () {
                    // Videoni o'ynatish mantiqi
                    if (url.isNotEmpty) {
                      // Agar VideoPlayerScreen sahifangiz tayyor bo'lsa, uni chaqiring:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoUrl: url,
                            title: video['title'] ?? "Untitled",
                          ),
                        ),
                      );
                    }
                  },
                  child: _buildProgressCard(
                    title: video['title'] ?? "Untitled Video",
                    percent: (video['progress'] ?? 0.0).toDouble(),
                    icon: Icons.play_circle_outline,
                    color: index % 2 == 0
                        ? const Color(0xFF5474FF)
                        : Colors.orangeAccent,
                  ),
                );
                // O'ZGARIYOTGAN QISM TUGADI
              },
            );
          },
        ),
      ],
    );
  }

  // Qolgan yordamchi UI metodlari (o'zgarishsiz)
  Widget _buildCategoryChip(String label, bool isSelected, IconData? icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF5474FF) : const Color(0xFF262A35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.white),
          if (icon != null) const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required double percent,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF262A35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF181A20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percent,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${(percent * 100).toInt()}%",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.play_arrow, size: 20, color: Color(0xFF5474FF)),
        ],
      ),
    );
  }

  Widget _buildGrowthCard() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: const Center(
        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
      ),
    );
  }
}
