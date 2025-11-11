import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tipsList = [
      {
        'title': '1. Bersihkan Kuku Secara Rutin',
        'desc':
            'Gunakan sikat kuku lembut dan sabun ringan untuk menghilangkan kotoran serta menjaga kuku tetap sehat.',
      },
      {
        'title': '2. Gunakan Pelembab Kuku dan Kulit Sekitar',
        'desc':
            'Oleskan minyak kuku atau hand cream setiap hari agar kuku tidak kering dan rapuh.',
      },
      {
        'title': '3. Hindari Pemotongan Terlalu Pendek',
        'desc':
            'Potong kuku seperlunya agar tidak melukai kulit di bawahnya atau menyebabkan kuku tumbuh ke dalam.',
      },
      {
        'title': '4. Gunakan Kutek Berkualitas',
        'desc':
            'Pilih produk kutek yang aman dan hindari bahan kimia keras yang dapat merusak permukaan kuku.',
      },
      {
        'title': '5. Istirahatkan Kuku dari Kutek',
        'desc':
            'Berikan waktu bagi kuku untuk “bernapas” tanpa cat kuku setidaknya seminggu setiap beberapa bulan.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tips & Perawatan Kuku')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tipsList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.pink.shade50,
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.spa, color: Colors.pink),
              title: Text(
                tipsList[index]['title']!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                tipsList[index]['desc']!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
