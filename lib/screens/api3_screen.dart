import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class Api3Screen extends StatelessWidget {
  const Api3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API 3')),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Página API 3', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
