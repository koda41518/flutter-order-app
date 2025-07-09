import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'sign_in_screen.dart';
import 'success_sign_up_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 8),
                const Text("Sign Up", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Register and eat", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),

                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade200,
                    child: TextButton(
                      onPressed: () {
                        // ajouter plus tard : image picker
                      },
                      child: const Text("Add\nPhoto", textAlign: TextAlign.center),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                CustomTextField(label: "Full Name", hint: "Type your full name"),
                CustomTextField(label: "Email Address", hint: "Type your email address"),
                CustomTextField(label: "Password", hint: "Type your password", obscure: true),

                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SuccessSignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF002B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Continue"),
                  ),
                ),

                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "I Already Have an Account ",
                        children: [
                          TextSpan(
                            text: "Log in",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}