import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppConstructor',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/api2': (context) => const Api2Screen(),
        '/api3': (context) => const Api3Screen(),
      },
    );
  }
}

/// Drawer shared across all pages for navigation.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Secciones',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chatbot'),
            onTap: () => Navigator.pushReplacementNamed(context, '/chatbot'),
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('API 2'),
            onTap: () => Navigator.pushReplacementNamed(context, '/api2'),
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('API 3'),
            onTap: () => Navigator.pushReplacementNamed(context, '/api3'),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 8.0),
            child: const Text(
              'Test Slice de 10 Cards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 26.0),
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Container(
                    width: 230,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Card ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Expanded(
            child: Center(child: Text('Welcome to Home!')),
          ),
        ],
      ),
    );
  }
}

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Chatbot Screen')),
    );
  }
}

class Api2Screen extends StatelessWidget {
  const Api2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API 2')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('API 2 Screen')),
    );
  }
}

class Api3Screen extends StatelessWidget {
  const Api3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API 3')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('API 3 Screen')),
    );
  }
}

