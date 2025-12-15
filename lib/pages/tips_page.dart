import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
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
                  "Tips Kecantikan",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Inspirasi harian untuk kuku indahmu",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // ISI KONTEN LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.lightbulb, color: Color(0xFFAD1457)),
                    ),
                    title: Text("Tips Cantik #${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                    subtitle: const Text("Cara merawat kuku agar tetap sehat dan berkilau alami...", maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}