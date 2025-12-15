import 'package:flutter/material.dart';
import 'package:pa_arif_uts/pages/auth/login_page.dart';
import 'package:pa_arif_uts/pages/auth/profile_page.dart';
import 'package:pa_arif_uts/pages/riwayat_page.dart';
import 'package:pa_arif_uts/pages/tips_page.dart';
import 'package:pa_arif_uts/pages/upload_page.dart'; // Pastikan import ini ada
import 'package:pa_arif_uts/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final session = await AuthService.getUserSession();
    setState(() {
      userName = session['name']!;
      userEmail = session['email']!;
    });
  }

  // --- LOGIC POPUP PROFILE ---
  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Gunakan Align untuk memindah posisi Dialog
        return Align(
          alignment: Alignment.topRight, // Pindah ke Kanan Atas
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 20), // Beri jarak dari pinggir layar
            child: Material( // Bungkus Material agar styling tetap bagus
              color: Colors.transparent,
              child: Container(
                width: 300, // Lebar tetap agar ramping
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    // HEADER PINK
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(
                        color: Color(0xFFAD1457),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const CircleAvatar(
                              radius: 40, 
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person, size: 50, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            userName.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(userEmail, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),

                    // TOMBOL PROFIL & LOGOUT
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text("Profil", style: TextStyle(color: Colors.black87)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await AuthService.logout();
                                if (mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                    (route) => false,
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text("Logout", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // --- WIDGET MAPS SALON (Placeholder UI) ---
  Widget _buildMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Salon Terdekat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
        ),
        const SizedBox(height: 15),
        
        // CONTAINER PETA
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            // Menggunakan gambar peta statis sebagai background agar terlihat seperti maps
            image: const DecorationImage(
              image: NetworkImage("https://img.freepik.com/free-vector/city-map-navigation-gps-app-interface_1017-13396.jpg"), 
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Overlay Gelap sedikit agar tulisan terbaca
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              // Pin Salon 1
              Positioned(
                top: 50,
                left: 100,
                child: _buildMapPin("BeautyNail Tegal"),
              ),
              // Pin Salon 2
              Positioned(
                bottom: 60,
                right: 80,
                child: _buildMapPin("Salon Cantik"),
              ),
              // Tombol Buka Maps
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Membuka Google Maps...")));
                  },
                  icon: const Icon(Icons.map, size: 16),
                  label: const Text("Lihat Peta Penuh"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFAD1457),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        
        const SizedBox(height: 15),
        
        // LIST SALON DI BAWAH PETA
        SizedBox(
          height: 120,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: [
              _buildSalonCard("BeautyNail Pusat", "0.5 km", "Jl. Kapten Sudibyo", 4.8),
              _buildSalonCard("Salon Muslimah", "1.2 km", "Jl. Werkudoro", 4.5),
              _buildSalonCard("Nail Art Express", "2.0 km", "Pacific Mall", 4.2),
            ],
          ),
        )
      ],
    );
  }

  // Widget Pin Peta Kecil
  Widget _buildMapPin(String name) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)]
          ),
          child: Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        const Icon(Icons.location_on, color: Color(0xFFAD1457), size: 35),
      ],
    );
  }

  // Widget Kartu Salon Horizontal
  Widget _buildSalonCard(String name, String distance, String address, double rating) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(children: [const Icon(Icons.star, size: 14, color: Colors.amber), Text(rating.toString(), style: const TextStyle(fontSize: 12))]),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(child: Text(address, style: const TextStyle(fontSize: 11, color: Colors.grey), overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFFCE4EC), borderRadius: BorderRadius.circular(5)),
            child: Text("$distance dari lokasimu", style: const TextStyle(fontSize: 10, color: Color(0xFFAD1457), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }


  // --- WIDGET HALAMAN HOME (REVISI) ---
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFFAD1457),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Halo, $userName!", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text("Mau cantik apa hari ini?", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                GestureDetector(
                  onTap: _showProfileDialog,
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    child: const CircleAvatar(radius: 25, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white, size: 30)),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          
          // --- BANNER ANALISIS AI (VERSI BARU: VERTIKAL) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Fitur Unggulan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
                const SizedBox(height: 15),
                
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    // Tinggi disesuaikan agar muat layout vertikal
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFAD1457), Color(0xFFD81B60)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: const Color(0xFFAD1457).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 1. TEKS DI ATAS
                        const Text("Analisis AI Smart", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text(
                          "Upload foto tanganmu untuk rekomendasi warna terbaik",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                        
                        const SizedBox(height: 20),

                        // 2. GAMBAR/IKON KAMERA DI TENGAH
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)
                          ),
                          child: const Icon(Icons.camera_enhance, size: 60, color: Colors.white),
                        ),

                        const SizedBox(height: 20),

                        // 3. TOMBOL COBA SEKARANG DI BAWAH
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min, // Agar lebar tombol menyesuaikan isi
                            children: [
                              Text("COBA SEKARANG", style: TextStyle(color: Color(0xFFAD1457), fontWeight: FontWeight.bold)),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, color: Color(0xFFAD1457), size: 18)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),
                
                // --- BAGIAN BARU: MAPS SALON TERDEKAT ---
                // Saya bungkus dalam widget terpisah agar rapi
              ],
            ),
          ),
          
          // Panggil Widget Maps
          _buildMapSection(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      const RiwayatPage(),
      const TipsPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFFAD1457),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.tips_and_updates), label: "Tips"),
        ],
      ),
    );
  }
}