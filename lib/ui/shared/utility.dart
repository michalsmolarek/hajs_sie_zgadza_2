import 'package:flutter/material.dart';

class Utility {
  static const PRIMARY_COLOR = Color(0xFF24B4A5);
  static const PRIMARY_COLOR_LIGHTER = Color(0xFF8FEDC2);
  static const BG_COLOR = Color(0xFFF4F3ED);
  static const GRADIENT = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: [PRIMARY_COLOR_LIGHTER, PRIMARY_COLOR]);
}
