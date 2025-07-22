import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';
import '../core/providers/auth_provider.dart'; // ou core/providers

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    nameCtrl.dispose();
    super.dispose();
  }

  void _signUp() async {
    final email = emailCtrl.text.trim();
    final pwd = passwordCtrl.text;
    final confirm = confirmCtrl.text;
    final name = nameCtrl.text.trim();

    if (pwd != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    setState(() => loading = true);
    final ok = await context.read<AuthProvider>().signUp(email, pwd, name);
    setState(() => loading = false);

    if (ok) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Échec de l'inscription")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'), backgroundColor: const Color(0xFFFF002B)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: emailCtrl,
                  label: "Email Address",
                  hint: "Type your email address",
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: passwordCtrl,
                  label: "Password",
                  hint: "Type your password",
                  obscure: true,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: confirmCtrl,
                  label: "Confirm Password",
                  hint: "Re-type your password",
                  obscure: true,
                ),
                CustomTextField(
                  controller: nameCtrl,
                  label: "Full Name",
                  hint: "Type your full name",
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF002B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        children: [
                          TextSpan(text: "Sign In", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}