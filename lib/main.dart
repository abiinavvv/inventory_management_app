// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_management/screens/home_page.dart';

void main() {
  runApp(const InventoryApp());
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AlgoBotix Inventory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0052CC),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0052CC),
            primary: const Color(0xFF0052CC),
          ),
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const InventoryListScreen());
  }
}
