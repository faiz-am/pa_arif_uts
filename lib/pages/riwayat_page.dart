import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> riwayatList = [
      {'title': 'Desain Nail Art 1', 'date': '10 November 2025'},
      {'title': 'Desain Nail Art 2', 'date': '8 November 2025'},
      {'title': 'Desain Nail Art 3', 'date': '5 November 2025'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Favorit'),
        backgroundColor: Colors.pink,
      ),
      body: riwayatList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat favorit.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: riwayatList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final item = riwayatList[index];
                return Card(
                  color: Colors.pink.shade50,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.pink),
                    title: Text(
                      item['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Ditambahkan pada: ${item['date']}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
