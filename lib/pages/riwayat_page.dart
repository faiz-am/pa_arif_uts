import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih sama dengan home
      body: Column(
        children: [
          // HEADER CUSTOM (Sama seperti Home Page)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFFAD1457), // Pink Gelap
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Tulisan di Kiri
              children: [
                Text(
                  "Riwayat Favorit",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Pantau status favorit kamu",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // ISI KONTEN
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  const Text("Belum ada riwayat transaksi", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}