
import 'package:color_predection_game/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeApp(); // Call your initialization logic
  }

  // This is where you can load settings, check for user login, etc.
  void initializeApp() async {
    // Simulate some loading time (e.g., loading assets, user data)
    // In a real app, this would be where you await things like:
    // - await Firebase.initializeApp()
    // - await loadUserSettings()
    await Future.delayed(const Duration(seconds: 2));
    // print("App initialization complete.");

    // 4. Remove the splash screen
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chroma Clash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationMenu(), // Your first screen after the splash
    );
  }
}