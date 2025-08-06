import 'package:flutter/material.dart';

class GameNavBar extends StatefulWidget {
  final Function(int) onTabChange;
  final int currentIndex;

  const GameNavBar({
    Key? key,
    required this.onTabChange,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _GameNavBarState createState() => _GameNavBarState();
}

class _GameNavBarState extends State<GameNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabChange,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gamepad_outlined),
          activeIcon: Icon(Icons.gamepad),
          label: 'Game',
          tooltip: 'Start new game',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}