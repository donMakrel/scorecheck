import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static final basicStyle = GoogleFonts.karla(
    //height: 2.5,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF080A38),
  );

  static final signStyle = GoogleFonts.karla(
    fontSize: 16,
    letterSpacing: -1,
    color: const Color(0xFF080A38),
  );

  static final titleStyle = GoogleFonts.karla(
    color: const Color(0xFF080A38),
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static final greyKarla = GoogleFonts.karla(
    color: Colors.grey,
  );

  static final boldStyle = GoogleFonts.karla(
    //height: 2.5,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF080A38),
  );

  static final playerStyle = GoogleFonts.karla(
    fontSize: 19,
    letterSpacing: -1,
    color: const Color(0xFF080A38),
  );
}
