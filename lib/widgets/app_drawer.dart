import 'package:flutter/material.dart';
import '../data/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _go(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name == route) {
      Navigator.pop(context);
      return;
    }
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text(
              'Appstract',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _DrawerItem(
            icon: Icons.home,
            label: 'Panel',
            selected: current == AppRoutes.home,
            onTap: () => _go(context, AppRoutes.home),
          ),
          _DrawerItem(
            icon: Icons.smart_toy,
            label: 'Chatbot',
            selected: current == AppRoutes.chatbot,
            onTap: () => _go(context, AppRoutes.chatbot),
          ),
          _DrawerItem(
            icon: Icons.api,
            label: 'API 2',
            selected: current == AppRoutes.api2,
            onTap: () => _go(context, AppRoutes.api2),
          ),
          _DrawerItem(
            icon: Icons.api,
            label: 'API 3',
            selected: current == AppRoutes.api3,
            onTap: () => _go(context, AppRoutes.api3),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          color: selected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
