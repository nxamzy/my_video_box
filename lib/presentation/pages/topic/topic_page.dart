import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  // Statik darslar ro'yxati (buni keyinchalik Firestore'dan olsang bo'ladi)
  final List<Map<String, dynamic>> lessons = [
    {
      "id": "1",
      "title": "Buffer Overflow tushunchasi",
      "subtitle": "Xotira boshqaruvi kirish",
      "duration": "05:40",
      "isCompleted": true,
      "thumbnail":
          "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400",
    },
    {
      "id": "2",
      "title": "Cross-Site Scripting (XSS)",
      "subtitle": "Klient-tomonlama hujumlar",
      "duration": "12:15",
      "isCompleted": false,
      "isLocked": false,
      "thumbnail":
          "https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400",
    },
    {
      "id": "3",
      "title": "Man-in-the-Middle hujumlari",
      "subtitle": "Tarmoqni ushlab qolish",
      "duration": "08:20",
      "isCompleted": false,
      "isLocked": true,
      "thumbnail":
          "https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=400",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // To'q fon
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildProgressHeader(),
            const SizedBox(height: 35),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Darslar ro'yxati",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "4 dars",
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // DARSLAR LISTI
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lessons.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return _buildLessonCard(lessons[index]);
              },
            ),
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
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Software Security",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF326CFE),
            const Color(0xFF326CFE).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF326CFE).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "KURS PROGRESSI",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "45%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Yaxshi ketyapsiz!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.45,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson) {
    bool isCompleted = lesson['isCompleted'] ?? false;
    bool isLocked = lesson['isLocked'] ?? false;

    return Opacity(
      opacity: isLocked ? 0.5 : 1.0, // Qulflangan bo'lsa xiraroq bo'ladi
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            // THUMBNAIL QISMI
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    lesson['thumbnail'],
                    width: 90,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                // O'ynatish yoki Qulf ikonasi
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isLocked ? Colors.black45 : Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isLocked ? Icons.lock : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),

            // MATN QISMI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${lesson['subtitle']} • ${lesson['duration']}",
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),

            // STATUS IKONASI
            if (isCompleted)
              const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 24)
            else if (!isLocked)
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white10,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
