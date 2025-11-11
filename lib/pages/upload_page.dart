import 'package:flutter/material.dart';
import 'analysis_page.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_search, size: 120, color: Colors.pinkAccent),
          const SizedBox(height: 20),
          const Text(
            "Unggah Foto Kuku Anda",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            icon: const Icon(Icons.upload, color: Colors.white),
            label: const Text("Pilih Foto", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalysisPage()));
            },
          ),
        ],
      ),
    );
  }
}
