import 'package:flutter/material.dart';
import 'package:pa_arif_uts/pages/auth/login_page.dart';
import 'package:pa_arif_uts/pages/home_page.dart';
import 'package:pa_arif_uts/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna Utama: Pink Gelap (Elegant Rose)
    const Color primaryColor = Color(0xFFAD1457); 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeautyNail',
      theme: ThemeData(
        useMaterial3: true,
        // Set Background Putih Bersih
        scaffoldBackgroundColor: Colors.white,
        
        // Skema Warna Utama
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: const Color(0xFFD81B60),
        ),

        // Style AppBar (Bagian Atas)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // AppBar Putih agar bersih
          foregroundColor: primaryColor, // Teks Pink
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        ),

        // Style Tombol (Elevated Button)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),

        // Style Input Text (Form)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFCE4EC), // Pink sangat muda untuk background input
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      // Cek status login
      home: FutureBuilder<bool>(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}