import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pa_arif_uts/pages/home_page.dart';
import 'package:pa_arif_uts/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Warna yang sama: Dusty Rose
  final Color _elegantPink = const Color(0xFF883955);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '585593837076-tpgn5tqhcf320jr8713arort017csufo.apps.googleusercontent.com', 
    scopes: ['email'],
  );

  void _handleRegister() async {
    setState(() => _isLoading = true);
    final result = await AuthService.register(_nameController.text, _emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (result['status']) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil! Silahkan Login.")));
        Navigator.pop(context);
      }
    } else {
      if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }

  void _handleGoogleRegister() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      setState(() => _isLoading = true);
      final result = await AuthService.googleAuthBackend(googleUser.email, googleUser.displayName ?? "No Name", googleUser.id);
      setState(() => _isLoading = false);

      if (result['status']) {
        await AuthService.saveUserSession(result['data']);
        if(mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background Abu Putih
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CONTAINER FORM
              Container(
                width: 400,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Buat Akun",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: _elegantPink
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Daftar untuk menikmati fitur BeautyNail",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // INPUT NAMA
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: Icon(Icons.person_outline, color: _elegantPink),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _elegantPink, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // INPUT EMAIL
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined, color: _elegantPink),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _elegantPink, width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // INPUT PASSWORD
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline, color: _elegantPink),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _elegantPink, width: 1.5)),
                      ),
                    ),
                    
                    const SizedBox(height: 30),

                    // TOMBOL REGISTER
                    _isLoading 
                      ? CircularProgressIndicator(color: _elegantPink)
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _elegantPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: const Text("DAFTAR SEKARANG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // DIVIDER
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text("ATAU", style: TextStyle(color: Colors.grey[400], fontSize: 12))),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // GOOGLE REGISTER
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _handleGoogleRegister,
                        icon: const Icon(Icons.g_mobiledata, size: 28),
                        label: const Text("Daftar dengan Google"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.grey[300]!),
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // KEMBALI KE LOGIN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sudah punya akun? ", style: TextStyle(color: Colors.grey[600])),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Login",
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
            ],
          ),
        ),
      ),
    );
  }
}