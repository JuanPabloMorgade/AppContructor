import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../data/constants.dart'; // AppRoutes y cardImages

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int totalCards = 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Panel')),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 8.0),
            child: Text(
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
                children: List.generate(totalCards, (index) {
                  final String heroTag = 'card_$index';
                  // Repite las 5 imágenes para completar las 10 cards
                  final String? imagePath = cardImages.isNotEmpty
                      ? cardImages[index % cardImages.length]
                      : null;

                  return Container(
                    width: 230,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            child: imagePath != null
                                ? InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes
                                            .preview, // usamos la constante
                                        arguments: {
                                          'imagePath': imagePath,
                                          'heroTag': heroTag,
                                          'title': 'Card ${index + 1}',
                                        },
                                      );
                                    },

                                    child: Hero(
                                      tag: heroTag,
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey.shade400,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Card ${index + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          const Expanded(child: Center(child: Text('Página Home!'))),
        ],
      ),
    );
  }
}
