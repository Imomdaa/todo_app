import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/styles/colors/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightgreen,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: GoogleFonts.elMessiri(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        centerTitle: false,
        // backgroundColor: Colors.transparent,
        // elevation: 0.0,
      ),
      textTheme: TextTheme(
      ));

  static ThemeData darkTheme = ThemeData();
}
