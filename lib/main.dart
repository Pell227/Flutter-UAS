import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'navbar.dart';
import 'component/navbarAnim.dart';
import 'profile.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1877F2),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
      routes: {'/home': (context) => const MainShell()},
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

  final int _friendRequests = 3;
  final int _notifications = 12;

  final List<Widget> _pages = const [
    Center(child: Text('Home feed')),
    Center(child: Text('Friends')),
    Center(child: Text('Search')),
    Center(child: Text('Reels')),
    ProfileScreen(),
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
        icon: Icons.search_outlined,
        activeIcon: Icons.search_rounded,
        label: 'Search',
      ),
      const NavItem(
        icon: Icons.movie_outlined,
        activeIcon: Icons.movie_rounded,
        label: 'Reels',
      ),
      NavItem(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Menu',
        badgeCount: _notifications,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AnimatedNavTransitionOverlay(
        currentIndex: _index,
        itemCount: items.length,
        child: AppBottomNavBar(
          currentIndex: _index,
          items: items,
          onTap: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}
