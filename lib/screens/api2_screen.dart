import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class Api2Screen extends StatelessWidget {
  const Api2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API 2')),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Página API 2', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
