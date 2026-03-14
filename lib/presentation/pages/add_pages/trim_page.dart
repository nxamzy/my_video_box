import 'package:flutter/material.dart';

class TrimPage extends StatefulWidget {
  const TrimPage({super.key});

  @override
  State<TrimPage> createState() => _TrimPageState();
}

class _TrimPageState extends State<TrimPage> {
  String selectedSkill = "Beginner"; // Skill Level holati

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // To'q ko'k fon (Rasmga asosan)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.white70),
        title: const Text(
          "New Knowledge Clip",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 16.0),
            child: Text(
              "Step 2/3",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tab Navigation (Media, Metadata, Review)
            _buildTabs(),
            const SizedBox(height: 25),

            // 2. Video Preview Section
            _buildVideoPreview(),
            const SizedBox(height: 25),

            // 3. Trim Clip Section
            _buildTrimSection(),
            const SizedBox(height: 35),

            // 4. Clip Details Header
            const Text(
              "Clip Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // 5. Title Input
            _buildLabel("Title"),
            _buildTextField("e.g. Intro to Buffer Overflow", suffix: "0/60"),
            const SizedBox(height: 20),

            // 6. Category & Sub-Topic Dropdowns
            Row(
              children: [
                Expanded(child: _buildDropdownField("Category", "Security")),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildDropdownField("Sub-Topic", "Ethical Hacking"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 7. Skill Level Selector
            _buildLabel("Skill Level"),
            _buildSkillSelector(),
            const SizedBox(height: 20),

            // 8. Link to Full Course
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel("Link to Full Course"),
                const Text(
                  "OPTIONAL",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            _buildTextField("https://udemy.com/course/...", icon: Icons.link),
            const SizedBox(height: 8),
            const Text(
              "This link will appear as a \"Watch Full Course\" button.",
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
            const SizedBox(height: 40),

            // 9. Bottom Buttons
            Row(
              children: [
                Expanded(child: _buildSecondaryButton("Save Draft")),
                const SizedBox(width: 15),
                Expanded(child: _buildPrimaryButton("Publish Clip")),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Vidjet Quruvchilar (Dizaynni bir xil qilish uchun) ---

  Widget _buildTabs() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("Media", style: TextStyle(color: Colors.white38)),
            Text(
              "Metadata",
              style: TextStyle(
                color: Color(0xFF4C82F7),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Review", style: TextStyle(color: Colors.white38)),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(height: 3, width: double.infinity, color: Colors.white10),
            Container(
              height: 3,
              width:
                  MediaQuery.of(context).size.width * 0.6, // Progress bar qismi
              decoration: BoxDecoration(
                color: const Color(0xFF4C82F7),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoPreview() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
            "https://via.placeholder.com/400x200",
          ), // O'rniga video thumb qo'yiladi
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "01:45",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrimSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Trim Clip",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Reset",
              style: TextStyle(color: Color(0xFF4C82F7), fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF4C82F7), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 8,
                height: double.infinity,
                color: const Color(0xFF4C82F7),
              ),
              const Spacer(),
              Container(
                width: 8,
                height: double.infinity,
                color: const Color(0xFF4C82F7),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField(String hint, {String? suffix, IconData? icon}) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        prefixIcon: icon != null
            ? Icon(icon, color: Colors.white38, size: 20)
            : null,
        suffixText: suffix,
        suffixStyle: const TextStyle(color: Colors.white24, fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(color: Colors.white)),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white38),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillSelector() {
    List<String> levels = ["Beginner", "Interm.", "Expert"];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: levels.map((level) {
          bool isSelected = selectedSkill == level;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedSkill = level),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF334155)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    level,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPrimaryButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF326CFE),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, size: 18),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E293B),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white70)),
    );
  }
}
