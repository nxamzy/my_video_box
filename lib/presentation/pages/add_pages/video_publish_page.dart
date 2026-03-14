import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoPublishPage extends StatefulWidget {
  final String videoPath; // Tanlangan video manzili

  const VideoPublishPage({super.key, required this.videoPath});

  @override
  State<VideoPublishPage> createState() => _VideoPublishPageState();
}

class _VideoPublishPageState extends State<VideoPublishPage> {
  final TextEditingController _titleController = TextEditingController();
  String selectedTopic = "Cyber Security";
  bool isPublic = true;

  // Mavzular ro'yxati
  final List<String> topics = [
    "Cyber Security",
    "UX Design",
    "Python",
    "Mobile Dev",
    "AI",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Nashr qilish",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Video Preview & Trim Placeholder
            _buildVideoPreview(),

            const SizedBox(height: 30),

            // 2. Video Title
            const Text(
              "Video nomi (ixtiyoriy)",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Masalan: Xavfsizlik darsi 1-qism",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: const Color(0xFF262A35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 3. Topic Selection
            const Text(
              "Mavzuni tanlang",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: topics
                  .map(
                    (topic) => ChoiceChip(
                      label: Text(topic),
                      selected: selectedTopic == topic,
                      onSelected: (selected) {
                        setState(() => selectedTopic = topic);
                      },
                      selectedColor: const Color(0xFF5474FF),
                      backgroundColor: const Color(0xFF262A35),
                      labelStyle: TextStyle(
                        color: selectedTopic == topic
                            ? Colors.white
                            : Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            // 4. Qo'shimcha sozlamalar (Switchlar)
            _buildSettingTile(
              "Hamma uchun ochiq",
              Icons.public,
              isPublic,
              (val) => setState(() => isPublic = val),
            ),
            _buildSettingTile(
              "Sharhlarga ruxsat",
              Icons.comment,
              true,
              (val) {},
            ),

            const SizedBox(height: 40),

            // 5. Publish Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Yuklash jarayonini boshlash
                  _startUpload();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5474FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "YUKLASH",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Video Preview UI
  Widget _buildVideoPreview() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF262A35),
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800',
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.content_cut, color: Colors.white, size: 14),
                  SizedBox(width: 5),
                  Text(
                    "TRIM",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Setting Row UI
  Widget _buildSettingTile(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: CupertinoSwitch(
        value: value,
        activeColor: const Color(0xFF5474FF),
        onChanged: onChanged,
      ),
    );
  }

  void _startUpload() {
    // Bu yerda backendga yuborish kodi bo'ladi
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Color(0xFF262A35),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF5474FF)),
            SizedBox(height: 20),
            Text("Video yuklanmoqda...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    // 3 soniyadan keyin dialogni yopish (simulatsiya)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Dialog yopiladi
      Navigator.pop(context); // Sahifadan chiqiladi
    });
  }
}
