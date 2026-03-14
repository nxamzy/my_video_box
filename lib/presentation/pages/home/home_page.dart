import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_folder_app/presentation/pages/add_pages/add_video_page.dart';
import 'package:my_folder_app/presentation/pages/library/library_page.dart';
import 'package:my_folder_app/presentation/pages/profile/profile_page.dart';
import 'package:my_folder_app/presentation/pages/topic/topic_page.dart';
import 'package:my_folder_app/presentation/pages/video_player_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;
  String _userName = "Dasturchi";
  String _selectedCategory = "All"; // Filter uchun

  // Kategoriyalar ro'yxati
  final List<Map<String, dynamic>> _categories = [
    {"name": "All", "icon": Icons.all_inclusive},
    {"name": "Cyber Security", "icon": Icons.security},
    {"name": "UX Design", "icon": Icons.brush},
    {"name": "Python", "icon": Icons.code},
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _getUserData();
  }

  void _getUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() => _userName = user.displayName ?? "Foydalanuvchi");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        _buildHomeTab(),
        const TopicPage(),
        const AddVideoPage(),
        const MyCourseLibrary(),
        const ProfilePage(),
      ],
      items: _navBarsItems(),
      backgroundColor: const Color(0xFF1E293B), // To'q ko'rkli rang
      navBarStyle: NavBarStyle.style15, // Markazdagi ADD tugmasi ajralib turadi
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
        ],
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    _navItem(Icons.home_filled, "Home"),
    _navItem(Icons.grid_view_rounded, "Topics"),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add, color: Colors.white, size: 30),
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.grey,
    ),
    _navItem(Icons.play_lesson_rounded, "Library"),
    _navItem(Icons.person_rounded, "Profile"),
  ];

  PersistentBottomNavBarItem _navItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title,
      activeColorPrimary: const Color(0xFF5474FF),
      inactiveColorPrimary: Colors.blueGrey[300]!,
    );
  }

  Widget _buildHomeTab() => Scaffold(
    backgroundColor: const Color(0xFF0F172A),
    appBar: _buildAppBar(),
    body: RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeText(),
            const SizedBox(height: 25),
            _buildCategoryList(),
            const SizedBox(height: 30),
            _buildSectionHeader("Davom ettirish", () {}),
            const SizedBox(height: 15),
            _buildVideoList(), // Dinamik ro'yxat
            const SizedBox(height: 30),
            _buildSectionHeader("Tavsiya etilgan", () {}),
            const SizedBox(height: 15),
            _buildFeaturedCard(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    ),
  );

  PreferredSizeWidget _buildAppBar() => AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      "Learning Hub",
      style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
    ),
    actions: [
      _appBarAction(CupertinoIcons.search, () {}),
      _appBarAction(CupertinoIcons.bell, () {}),
      const SizedBox(width: 10),
    ],
  );

  Widget _appBarAction(IconData icon, VoidCallback onTap) => IconButton(
    onPressed: onTap,
    icon: Icon(icon, color: Colors.white70, size: 22),
  );

  Widget _buildWelcomeText() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Xayrli kech,",
        style: TextStyle(fontSize: 24, color: Colors.blueGrey),
      ),
      Text(
        "$_userName! 🔥",
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    ],
  );

  Widget _buildCategoryList() => SizedBox(
    height: 45,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final cat = _categories[index];
        bool isSelected = _selectedCategory == cat['name'];
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = cat['name']),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF5474FF)
                  : const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(15),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF5474FF).withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  cat['icon'],
                  color: isSelected ? Colors.white : Colors.blueGrey,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  cat['name'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _buildSectionHeader(String title, VoidCallback onTap) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TextButton(
        onPressed: onTap,
        child: const Text(
          "Hammasi",
          style: TextStyle(color: Color(0xFF5474FF)),
        ),
      ),
    ],
  );

  Widget _buildVideoList() {
    // Kategoriyaga qarab queryni o'zgartiramiz
    Query query = FirebaseFirestore.instance
        .collection('videos')
        .orderBy('createdAt', descending: true);
    if (_selectedCategory != "All") {
      query = query.where('category', isEqualTo: _selectedCategory);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Text(
            "Xatolik yuz berdi",
            style: TextStyle(color: Colors.red),
          );
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CupertinoActivityIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "Hozircha videolar yo'q",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (c, i) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return _buildProgressCard(data);
          },
        );
      },
    );
  }

  Widget _buildProgressCard(Map<String, dynamic> data) {
    double progress = (data['progress'] ?? 0.0).toDouble();
    return InkWell(
      onTap: () {
        if (data['videoUrl'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => VideoPlayerScreen(
                videoUrl: data['videoUrl'],
                title: data['title'] ?? "Video",
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.play_circle_fill,
                color: Color(0xFF5474FF),
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] ?? "Nomsiz dars",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF5474FF)),
                    minHeight: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${(progress * 100).toInt()}%",
              style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() => Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        colors: [Color(0xFF5474FF), Color(0xFF8E54FF)],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -20,
          bottom: -20,
          child: Icon(
            Icons.rocket_launch,
            size: 150,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Premium Kurslar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Batafsil"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
