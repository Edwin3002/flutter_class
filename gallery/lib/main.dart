import 'package:flutter/material.dart';
import 'package:gallery/screens/home_view.dart';

void main() {

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: Colors.deepPurpleAccent,
          navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white),
          ))),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          backgroundColor: Colors.deepPurpleAccent,
          indicatorColor: Colors.deepPurpleAccent,
          selectedIndex: currentPageIndex,
          surfaceTintColor: Colors.red,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home_outlined, color: Colors.white),
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings_outlined, color: Colors.white),
              icon: Icon(Icons.settings, color: Colors.white),
              label: 'Settings',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite_outline, color: Colors.white),
              icon: Icon(Icons.favorite, color: Colors.white),
              label: 'Favorite',
            ),
          ],
        ),
        body: const Center(
          child: HomeView(),
        ),
      ),
    );
  }
}
