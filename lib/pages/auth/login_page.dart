import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pa_arif_uts/pages/auth/register_page.dart';
import 'package:pa_arif_uts/pages/home_page.dart';
import 'package:pa_arif_uts/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Warna Khusus: Dusty Rose (Pink Gelap Elegan - Tidak terlalu 'cewek')
  final Color _elegantPink = const Color(0xFF883955); 

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '585593837076-tpgn5tqhcf320jr8713arort017csufo.apps.googleusercontent.com', 
    scopes: ['email'],
  );

  void _handleManualLogin() async {
    setState(() => _isLoading = true);
    final result = await AuthService.login(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (result['status']) {
      await AuthService.saveUserSession(result['data']);
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }

  void _handleGoogleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      setState(() => _isLoading = true);
      final result = await AuthService.googleAuthBackend(googleUser.email, googleUser.displayName ?? "No Name", googleUser.id);
      setState(() => _isLoading = false);

      if (result['status']) {
        await AuthService.saveUserSession(result['data']);
        if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
      }
    } catch (error) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background Putih Sedikit Abu
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CONTAINER FORM (KOTAK TENGAH)
              Container(
                width: 400, // Batasi lebar agar rapi di Web
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white, // Warna Container Putih Bersih
                  borderRadius: BorderRadius.circular(20), // Sudut melengkung
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05), // Bayangan tipis
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // LOGO & JUDUL
                    Icon(Icons.spa, size: 60, color: _elegantPink),
                    const SizedBox(height: 15),
                    Text(
                      "BeautyNail",
                      style: TextStyle(
                        fontSize: 26, 
                        fontWeight: FontWeight.bold, 
                        color: _elegantPink,
                        letterSpacing: 1.2
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Masuk untuk melanjutkan",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 30),

                    // INPUT EMAIL
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "nama@email.com",
                        prefixIcon: Icon(Icons.email_outlined, color: _elegantPink),
                        filled: true,
                        fillColor: Colors.grey[50], // Input agak abu dikit
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: _elegantPink, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // INPUT PASSWORD
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline, color: _elegantPink),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: _elegantPink, width: 1.5),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),

                    // TOMBOL LOGIN MANUAL
                    _isLoading 
                      ? CircularProgressIndicator(color: _elegantPink)
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleManualLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _elegantPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: const Text("LOGIN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // DIVIDER
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("ATAU", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // TOMBOL GOOGLE
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _handleGoogleLogin,
                        icon: const Icon(Icons.g_mobiledata, size: 28),
                        label: const Text("Masuk dengan Google"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.grey[300]!),
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // LINK KE REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Belum punya akun? ", style: TextStyle(color: Colors.grey[600])),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              color: _elegantPink, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              // Footer kecil
              Text("BeautyNail © 2024", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}