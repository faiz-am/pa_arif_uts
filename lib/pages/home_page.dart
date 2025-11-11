import 'package:flutter/material.dart';
import 'analysis_page.dart';
import 'tips_page.dart';
import 'map_page.dart';
import 'auth/login_page.dart';
import 'auth/profile_page.dart';
import 'riwayat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLoggedIn = false; // status login sementara

  final List<Widget> _pages = const [
    HomeContent(),
    TipsPage(),
    MapPage(),
    RiwayatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk pindah login / profil
  void _onAccountPressed(BuildContext context) {
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      ).then((_) {
        // jika logout dilakukan, ubah status login jadi false
        setState(() {
          isLoggedIn = false;
        });
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      ).then((value) {
        // misalnya setelah login sukses
        if (value == true) {
          setState(() {
            isLoggedIn = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'BeautyNail',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(isLoggedIn ? Icons.person : Icons.login),
            tooltip: isLoggedIn ? 'Profil' : 'Login / Register',
            onPressed: () => _onAccountPressed(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Tips'),
          BottomNavigationBarItem(
              icon: Icon(Icons.map), label: 'Salon'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Riwayat'),

        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image_search, color: Colors.pink, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Unggah Foto Kuku Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kami akan menganalisis bentuk kuku Anda dan memberikan rekomendasi terbaik.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalysisPage()),
                );
              },
              icon: const Icon(Icons.upload),
              label: const Text('Pilih Foto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
