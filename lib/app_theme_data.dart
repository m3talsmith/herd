import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 226, 130, 4);
const Color containerColor = Color.fromRGBO(255, 255, 255, 0.9);

class AppThemeData {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: primaryColor,
        cardTheme: const CardTheme(
          color: containerColor,
        ),
        menuTheme: const MenuThemeData(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(containerColor),
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: containerColor,
        ),
      );
}
