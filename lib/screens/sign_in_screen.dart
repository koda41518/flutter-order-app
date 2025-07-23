import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


import '../widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../core/providers/auth_provider.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void _signIn() async {
    setState(() => loading = true);
    final ok = await context.read<AuthProvider>().signIn(
      emailCtrl.text.trim(),
      passwordCtrl.text.trim(),
    );
    setState(() => loading = false);

    if (ok) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de connexion')),
      );
    }
  }

  String generateNonce(int length) {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final rand = Random.secure();
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
  }

  String sha256ofString(String input) =>
      sha256.convert(utf8.encode(input)).toString();

  Future<void> _signInWithApple() async {
    final rawNonce = generateNonce(32);
    final nonce = sha256ofString(rawNonce);

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      rawNonce: rawNonce,
    );

    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sign In", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Find your best ever meal", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                CustomTextField(controller: emailCtrl, label: "Email Address", hint: "Type your email address"),
                CustomTextField(controller: passwordCtrl, label: "Password", hint: "Type your password", obscure: true),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF002B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In"),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/sign-up'),
                    child: const Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: Text("- OR Continue with -")),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final user = await context.read<AuthProvider>().signInWithGoogle();
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Connexion Google échouée")),
                        );
                      }
                    },
                    icon: const Icon(Icons.email),
                    label: const Text("Sign in with Google"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (Platform.isIOS)
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.apple),
                      label: const Text("Sign in with Apple"),
                      onPressed: _signInWithApple,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
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