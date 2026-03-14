import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_folder_app/data/repositories/video_repositories.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final _titleController = TextEditingController();
  final _videoRepo = VideoRepository();
  final ImagePicker _picker = ImagePicker();

  File? _selectedVideo; // Tanlangan video fayli
  String selectedPath = "Cyber Security";
  bool _isUploading = false;

  // GALEREYADAN VIDEO TANLASH
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedVideo = File(video.path);
      });
    }
  }

  // SERVERGA YUKLASH
  Future<void> _upload() async {
    if (_selectedVideo == null || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Video tanlang va sarlavha yozing!")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Bu yerda biz video fayli yo'lini va ma'lumotlarni yuboramiz
      await _videoRepo.addVideo(
        title: _titleController.text.trim(),
        filePath: _selectedVideo!.path, // Parametr nomi endi filePath
        description: selectedPath,
      );

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Muvaffaqiyatli yuklandi!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Xato: $e")));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Yangi Video", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VIDEO TANLASH JOYI
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C222E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF5474FF).withOpacity(0.5),
                  ),
                ),
                child: _selectedVideo == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library,
                            color: Color(0xFF5474FF),
                            size: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Galereyadan video tanlash",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Video tanlandi",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 30),

            // KATEGORIYA TANLASH
            const Text(
              "Kategoriya",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            _buildDropdown(),

            const SizedBox(height: 20),

            // SARLAVHA KIRITISH
            const Text(
              "Video Sarlavhasi",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Masalan: Neural Networks asoslari",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: const Color(0xFF1C222E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // YUKLASH TUGMASI
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isUploading ? null : _upload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5474FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Serverga yuklash",
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

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C222E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPath,
          isExpanded: true,
          dropdownColor: const Color(0xFF1C222E),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: ["Cyber Security", "UX Design", "Python", "Neural Networks"]
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.white)),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => selectedPath = v!),
        ),
      ),
    );
  }
}
