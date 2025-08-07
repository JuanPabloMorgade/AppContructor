import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AppContructor')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título encima del slice
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 8.0),
            child: Text(
              'Test Slice de 10 Cards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Slice horizontal con tarjetas
          Container(
            margin: EdgeInsets.only(bottom: 26.0),
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return Container(
                    width: 230,
                    margin: EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Card ${index + 1}',
                        style: TextStyle(
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

          // Texto centrado debajo
          Expanded(child: Center(child: Text('Welcome to MyHomePage!'))),
        ],
      ),
    );
  }
}
