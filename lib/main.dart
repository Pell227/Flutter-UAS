import 'package:flutter/material.dart';
import 'navbar.dart';
void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1877F2),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  // Badge counts would normally come from your state management / backend.
  final int _friendRequests = 3;
  final int _notifications = 12;

  // Replace these placeholders with your teammates' real screens.
  final List<Widget> _pages = const [
    Center(child: Text('Home feed')),
    Center(child: Text('Friends')),
    Center(child: Text('Watch')),
    Center(child: Text('Notifications')),
    Center(child: Text('Menu / Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      const NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        label: 'Home',
      ),
      NavItem(
        icon: Icons.people_outline_rounded,
        activeIcon: Icons.people_alt_rounded,
        label: 'Friends',
        badgeCount: _friendRequests,
      ),
      const NavItem(
        icon: Icons.ondemand_video_outlined,
        activeIcon: Icons.ondemand_video_rounded,
        label: 'Watch',
      ),
      NavItem(
        icon: Icons.notifications_none_rounded,
        activeIcon: Icons.notifications_rounded,
        label: 'Notifications',
        badgeCount: _notifications,
      ),
      const NavItem(
        icon: Icons.menu_rounded,
        activeIcon: Icons.menu_open_rounded,
        label: 'Menu',
      ),
    ];

    return Scaffold(
      // IndexedStack keeps each tab's scroll position when you switch tabs.
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        items: items,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}