import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
          surface: Color(0xFF1C1C1E),
          // ignore: deprecated_member_use
          background: Color(0xFF000000),
        ),
        scaffoldBackgroundColor: const Color(0xFF000000),
        cardColor: const Color(0xFF1C1C1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C1C1E),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
