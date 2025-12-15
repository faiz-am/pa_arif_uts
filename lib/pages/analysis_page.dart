import 'package:flutter/material.dart';
import 'package:pa_arif_uts/pages/tryon_page.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data Produk Rekomendasi
    final List<Map<String, String>> recommendations = [
      {"name": "Maroon Matte", "color": "#800000", "desc": "Cocok untuk kulit sawo matang"},
      {"name": "Nude Pink", "color": "#FFC0CB", "desc": "Tampilan natural sehari-hari"},
      {"name": "Electric Blue", "color": "#0000FF", "desc": "Warna bold untuk pesta"},
      {"name": "Emerald Green", "color": "#50C878", "desc": "Kesan elegan dan mewah"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Analisis")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Hasil Analisis
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFCE4EC), // Pink Muda
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFAD1457)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.analytics, size: 40, color: Color(0xFFAD1457)),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tone Kulit: Sawo Matang", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Rekomendasi: Warna Gelap & Bold", style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 25),
            const Text("Rekomendasi Produk Untukmu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            const SizedBox(height: 15),

            // Grid Produk
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // Kartu agak memanjang ke bawah
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final product = recommendations[index];
                return GestureDetector(
                  onTap: () {
                    // Ke TryOn Page membawa data produk
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TryOnPage(
                      productName: product['name']!,
                      productColor: product['color']!,
                    )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Warna Kutek (Visualisasi)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(int.parse(product['color']!.replaceAll('#', '0xFF'))),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            ),
                            child: const Center(child: Icon(Icons.fingerprint, color: Colors.white24, size: 50)),
                          ),
                        ),
                        // Detail
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(product['desc']!, style: const TextStyle(fontSize: 10, color: Colors.grey), maxLines: 2),
                              const SizedBox(height: 10),
                              // Tombol Kecil
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFAD1457),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text("COBA VIRTUAL", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}