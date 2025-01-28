import 'package:flutter/material.dart';
import 'package:lg_task5/screens/gemini.dart';
import 'package:lg_task5/screens/animated_tab.dart';
import 'package:lg_task5/screens/progress_bar.dart';
import 'package:lg_task5/screens/search_page.dart';
import 'package:lg_task5/screens/settings_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin {
  int selectedNavIndex = 0;

  final List<Widget> pages = [
    SearchPage(),
    GeminiLogo(),
    ProgressBar(),
    SettingsPage(),
    AnimatedTabBar(),
  ];

  final List<String> bottomNavLabels = [
    "Task1",
    "Task2",
    "Task5",
    "Task6",
    "Task7",
  ];

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    setState(() {
      selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: IndexedStack(
              index: selectedNavIndex,
              children: pages,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 48, 47, 47).withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(bottomNavLabels.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _onTabChange(index);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            bottomNavLabels[index],
                            style: TextStyle(
                              color: selectedNavIndex == index
                                  ? const Color.fromARGB(255, 42, 242, 242)
                                  : Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 3,
                            width: selectedNavIndex == index ? 40 : 0,
                            decoration: BoxDecoration(
                              color: selectedNavIndex == index
                                  ? const Color.fromARGB(255, 42, 242, 242)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
