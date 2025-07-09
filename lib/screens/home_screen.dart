import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;
  String _animationPath = '';

  void _playAnimation(String assetPath) async {
    setState(() {
      isPlaying = true;
      _animationPath = assetPath;
    });
    await Future.delayed(const Duration(seconds: 3));
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose your favorite action!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _playAnimation('assets/images/Hourglass.gif'),
                      child: Column(
                        children: const [
                          Icon(Icons.hourglass_empty, size: 48, color: Colors.blue),
                          SizedBox(height: 4),
                          Text('Timer'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _playAnimation('assets/images/Loading-bar.gif'),
                      child: Column(
                        children: const [
                          Icon(Icons.cloud_download, size: 48, color: Colors.green),
                          SizedBox(height: 4),
                          Text('Download'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _playAnimation('assets/images/success_order.png'),
                      child: Column(
                        children: const [
                          Icon(Icons.check_circle, size: 48, color: Colors.orange),
                          SizedBox(height: 4),
                          Text('Success'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isPlaying)
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Image.asset(_animationPath, width: 100),
                ),
              ),
            ),
        ],
      ),
    );
  }
}