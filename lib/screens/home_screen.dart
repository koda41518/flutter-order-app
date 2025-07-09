import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;

  void _playAnimation() async {
    setState(() => isPlaying = true);
    await Future.delayed(const Duration(seconds: 3)); // durée de l’animation
    setState(() => isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to FoodMarket'),
        backgroundColor: const Color(0xFFFF002B),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Contenu principal
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose your favorite meal!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _playAnimation, // Appel de l’animation
                      child: Column(
                        children: const [
                          Icon(Icons.hourglass_empty, size: 48, color: Colors.blue),
                          SizedBox(height: 4),
                          Text('Timer'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    GestureDetector(
                      onTap: _playAnimation,
                      child: Column(
                        children: const [
                          Icon(Icons.cloud_download, size: 48, color: Colors.green),
                          SizedBox(height: 4),
                          Text('Download'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Animation de loader
          if (isPlaying)
            AnimatedOpacity(
              opacity: isPlaying ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: const Center(
                  child: Image(asset: 'assets/images/Hourglass.gif', width: 100),
                ),
              ),
            ),
        ],
      ),
    );
  }
}