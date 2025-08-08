import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../data/constants.dart';
import '../widgets/contact_form.dart';
import '../widgets/feriados_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _totalCards = 10;
  final PageController _pageController = PageController(viewportFraction: 0.78);
  late Timer _autoPlayTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageController.hasClients) return;
      _currentPage = (_currentPage + 1) % _totalCards;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18.0, 26.0, 18.0, 8.0),
              child: Text(
                'Test Slice de 10 Cards',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            // --- Carrusel ---
            SizedBox(
              height: 230,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _totalCards,
                      padEnds: false,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (context, index) {
                        final heroTag = 'card_$index';
                        final imagePath = cardImages.isNotEmpty
                            ? cardImages[index % cardImages.length]
                            : null;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: _CardItem(
                            imagePath: imagePath,
                            heroTag: heroTag,
                            title: 'Card ${index + 1}',
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_totalCards, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 8,
                        width: active ? 18 : 8,
                        decoration: BoxDecoration(
                          color: active
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // --- Feriados (con scroll propio) ---
            const SizedBox(height: 50),
            const _FeriadosSection(), // mantiene el SizedBox(height: 420) adentro
            const SizedBox(height: 50),
            // --- Formulario ---
            const ContactForm(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class _FeriadosSection extends StatelessWidget {
  const _FeriadosSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Feriados',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Alto fijo para que la lista maneje su propio scroll interno
        SizedBox(
          height: 450, // ajustá a gusto
          child: const FeriadosList(estado: 'todos', limit: 25),
        ),
      ],
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.imagePath,
    required this.heroTag,
    required this.title,
  });

  final String? imagePath;
  final String heroTag;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey.shade300,
      child: InkWell(
        onTap: imagePath == null
            ? null
            : () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.preview,
                  arguments: {
                    'imagePath': imagePath,
                    'heroTag': heroTag,
                    'title': title,
                  },
                );
              },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: imagePath != null
                  ? Hero(
                      tag: heroTag,
                      child: Image.asset(
                        imagePath!,
                        fit: BoxFit.cover,
                        width: double.infinity,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
