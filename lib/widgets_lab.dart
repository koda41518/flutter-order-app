import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetsLabApp());
}

class WidgetsLabApp extends StatelessWidget {
  const WidgetsLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Lab',
      home: Scaffold(
        appBar: AppBar(title: const Text("Tests de Widgets")),
        body: const Center(
          child: MonWidgetTest(),
        ),
      ),
    );
  }
}

class MonWidgetTest extends StatelessWidget {
  const MonWidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Voici un widget de test"),
        Icon(Icons.star, size: 48),
        ElevatedButton(onPressed: null, child: Text("Bouton désactivé"))
      ],
    );
  }
}