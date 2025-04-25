import 'package:flutter/material.dart';

import '../counter/counter.dart';
import '../settings/settings.dart';
import '../timer/timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return const DesktopHomePage();
        } else if (constraints.maxWidth > 800) {
          return const TabletHomePage();
        } else {
          return const MobileHomePage();
        }
      },
    );
  }
}

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Growth Gauge')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          CounterListWidget(),
          TimerListWidget(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Counters'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timers'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primaryFixedDim,
        ),
      ),
    );
  }
}

class TabletHomePage extends StatelessWidget {
  const TabletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Growth Gauge')),
      body: const Row(
        children: [
          Expanded(child: CounterListWidget()),
          Expanded(child: TimerListWidget()),
        ],
      ),
    );
  }
}

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  int _selectedIndex = 0;

  bool _isRailExtended = false;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _toggleRail() {
    setState(() {
      _isRailExtended = !_isRailExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            extended: _isRailExtended,
            onDestinationSelected: _onDestinationSelected,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Counters'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.timer),
                label: Text('Timers'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            leading: IconButton(
              tooltip: _isRailExtended ? 'Collapse' : 'Expand',
              icon: Icon(
                _isRailExtended ? Icons.chevron_left : Icons.chevron_right,
              ),
              onPressed: _toggleRail,
            ),
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
            ),
            selectedLabelTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            unselectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: const [
                CounterListWidget(),
                TimerListWidget(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
