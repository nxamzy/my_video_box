import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final List<Map<String, dynamic>> lessons = [
    {
      "id": "1",
      "title": "1. Buffer Overflow Explained",
      "subtitle": "Introduction to Memory",
      "duration": "0:58",
      "isCompleted": true,
      "thumbnail":
          "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=400",
    },
    {
      "id": "2",
      "title": "2. Cross-Site Scripting (XSS)",
      "subtitle": "Client-side Attacks",
      "duration": "0:45",
      "isCompleted": false,
      "thumbnail":
          "https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400",
    },
    {
      "id": "3",
      "title": "3. Man-in-the-Middle Attacks",
      "subtitle": "Network Interception",
      "duration": "1:05",
      "isCompleted": false,
      "thumbnail":
          "https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=400",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          "Software Security",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "COURSE PROGRESS",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "45%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Keep going!",
                  style: TextStyle(
                    color: Colors.blueAccent.shade100,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.45,
                minHeight: 8,
                backgroundColor: Colors.white10,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Up Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "4 Lessons",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return _buildLessonCard(lessons[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C222E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  lesson['thumbnail'],
                  width: 100,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    lesson['duration'],
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lesson['subtitle'],
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      "Full Lesson",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.blueAccent,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.bookmark_border, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}
