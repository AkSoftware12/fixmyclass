import 'dart:ui';
import 'package:flutter/material.dart';

import 'HexColorCode/HexColor.dart';

class AppColors {
  // static const Color primary = Color(0xFF041B7F); // Example primary color (blue)
  static  Color primary = HexColor('#1a434e'); // Example primary color (blue)
  static  Color secondary =HexColor('#1a434e'); // Secondary color (gray)
  // static const Color secondary = Color(0xFF074799); // Secondary color (gray)
  static  Color bottomBarBG =Colors.orange; // Secondary color (gray)
  static const Color grey = Color(0xFFAAAEB2); // Secondary color (gray)
  static const Color background = Color(0xFFF8F9FA); // Light background color
  static const Color textblack = Color(0xFF212529); // Dark text color
  static const Color textwhite = Color.fromARGB(255, 255, 255, 255); // Dark text color
  // static  Color textwhite = Colors.grey.shade500; // Dark text color
  static const Color error = Color(0xFFDC3545); // Error color (red)
  static const Color success = Color(0xFF28A745); // Success color (green)
  static const Color yellow = Color(0xFFCCAB21); // Success color (green)
}