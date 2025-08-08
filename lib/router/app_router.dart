import 'package:flutter/material.dart';
import '../data/constants.dart';
import '../screens/home_screen.dart';
import '../screens/chatbot_screen.dart';
import '../screens/api2_screen.dart';
import '../screens/api3_screen.dart';
import '../widgets/image_preview.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const HomeScreen());

      case AppRoutes.chatbot:
        return _buildRoute(const ChatbotScreen());

      case AppRoutes.api2:
        return _buildRoute(const Api2Screen());

      case AppRoutes.api3:
        return _buildRoute(const Api3Screen());

      case '/preview':
        // Esperamos recibir un Map con imagePath, heroTag, title
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null &&
            args['imagePath'] != null &&
            args['heroTag'] != null) {
          return _buildRoute(
            ImagePreviewScreen(
              imagePath: args['imagePath'],
              heroTag: args['heroTag'],
              title: args['title'],
            ),
          );
        }
        return _errorRoute("Datos inválidos para /preview");

      default:
        return _errorRoute("Ruta no encontrada: ${settings.name}");
    }
  }

  static MaterialPageRoute _buildRoute(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(message, style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
