import 'package:flutter/material.dart';

/// Pantalla de vista previa con zoom/pan y animación Hero.
/// Usa [ImagePreviewScreen] pasando:
///  - [imagePath]: ruta del asset (p.ej. 'assets/images/card1.jpg')
///  - [heroTag]: el mismo tag que usaste en la card para el Hero
///  - [title]: (opcional) título en el AppBar
class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({
    super.key,
    required this.imagePath,
    required this.heroTag,
    this.title,
  });

  final String imagePath;
  final String heroTag;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title ?? 'Vista previa'),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Hero(tag: heroTag, child: Image.asset(imagePath)),
        ),
      ),
    );
  }
}
