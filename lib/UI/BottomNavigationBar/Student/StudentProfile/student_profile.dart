import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MastProfileScreenState();
}

class _MastProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fade;
  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(fade);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B0E21),
      body: Stack(
        children: [
          // 🔹 Animated Gradient Background
          AnimatedContainer(
            duration: const Duration(seconds: 5),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff141E30), Color(0xff243B55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 Floating Glow Orbs
          Positioned(
            top: -120,
            left: -80,
            child: _glowOrb(300, const Color(0xff00C6FF)),
          ),
          Positioned(
            bottom: -150,
            right: -100,
            child: _glowOrb(400, const Color(0xff0072FF)),
          ),

          // 🔹 Main Scroll Content
          SafeArea(
            child: FadeTransition(
              opacity: fade,
              child: SlideTransition(
                position: slide,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Avatar
                      _frostedGlass(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    blurRadius: 35,
                                    spreadRadius: 3,
                                  )
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                AssetImage("assets/avatar_placeholder.png"),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text("Rahul Sharma",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(height: 4),
                            Text("STU12345",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 14,
                                )),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _chip("10th A"),
                                const SizedBox(width: 8),
                                _chip("IIT-JEE"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      _sectionTitle("Quick Stats", Icons.speed_rounded),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _statCard("Attendance", "95%", Colors.greenAccent),
                          _statCard("Grade", "A", Colors.orangeAccent),
                          _statCard("Subjects", "5", Colors.cyanAccent),
                          _statCard("Next Test", "25 Oct", Colors.pinkAccent),
                        ],
                      ),

                      const SizedBox(height: 25),
                      _sectionTitle("Personal Details", Icons.person_2_outlined),
                      const SizedBox(height: 12),
                      _glassTile(Icons.email, "Email", "rahul@example.com"),
                      _glassTile(Icons.phone, "Phone", "+91 98765 43210"),
                      _glassTile(
                          Icons.location_on, "Address", "Mumbai, Maharashtra"),
                      _glassTile(Icons.school, "School", "ABC High School"),

                      const SizedBox(height: 25),
                      _sectionTitle("Subjects", Icons.menu_book_rounded),
                      const SizedBox(height: 12),
                      _subject("Mathematics", "Advanced Level", Colors.indigo),
                      _subject("Physics", "JEE Main", Colors.blue),
                      _subject("Chemistry", "Organic Focus", Colors.red),
                      _subject("English", "Grammar & Vocab", Colors.green),
                      _subject("Biology", "Human Anatomy", Colors.teal),

                      const SizedBox(height: 30),
                      _button("View Attendance", Icons.calendar_month_rounded,
                          Colors.cyanAccent, true),
                      const SizedBox(height: 12),
                      _button("View Grades", Icons.star_rounded,
                          Colors.blueAccent, false),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 Reusable UI Components

  Widget _frostedGlass({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _glowOrb(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(0.4), Colors.transparent],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff00C6FF), Color(0xff0072FF)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 18),
        const SizedBox(width: 8),
        Text(title,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), Colors.white.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bolt, color: color, size: 26),
          const SizedBox(height: 8),
          Text(title,
              style:
              GoogleFonts.poppins(fontSize: 13, color: Colors.white70)),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _glassTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        color: Colors.white54, fontSize: 12)),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _subject(String name, String desc, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.book, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text(desc,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.white70)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.white30, size: 14),
        ],
      ),
    );
  }

  Widget _button(
      String label, IconData icon, Color color, bool outlined) {
    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: color),
        label: Text(label,
            style: GoogleFonts.poppins(
                color: color, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      )
          : ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(label,
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
