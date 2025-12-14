import 'package:flutter/material.dart';
import 'package:growth_gauge/ui/core/constants.dart';

import '../../activity/widgets/activity_list_page.dart';
import '../../counter/widgets/counter_list_widget.dart';
import '../../settings/widgets/settings_page.dart';
import '../../timer/widgets/timer_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kTabletScreenSize) {
          return const DesktopHomePage();
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
              icon: Icon(Icons.fitness_center), label: 'Activities'),
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
                icon: Icon(Icons.fitness_center),
                label: Text('Activities'),
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
                // Activities page
                ActivityListWidget(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
