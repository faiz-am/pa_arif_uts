import 'package:flutter/material.dart';

class TryOnPage extends StatelessWidget {
  final String productName;
  final String productColor;

  const TryOnPage({
    super.key, 
    required this.productName, 
    required this.productColor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Try-On")),
      body: Column(
        children: [
          // Area Simulasi (Placeholder Kamera/AR)
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Disini nanti bisa diganti tampilan Kamera / AR
                  const Icon(Icons.back_hand, color: Colors.white24, size: 150),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Sedang mencoba: $productName",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          
          // Panel Kontrol Bawah
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(int.parse(productColor.replaceAll('#', '0xFF'))), // Konversi Hex ke Color
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const Text("Tap layar untuk melihat hasil", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Produk ditambahkan ke keranjang!")));
                    },
                    child: const Text("BELI SEKARANG"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}