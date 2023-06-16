import 'package:flutter/material.dart';
import 'package:instagram_clone/Presenation/Navigationpage/NavigationBar.dart';
import 'package:instagram_clone/utenslis/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: kblack,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: kblack),
        appBarTheme: const AppBarTheme(backgroundColor: kblack),
        navigationBarTheme:
            const NavigationBarThemeData(backgroundColor: kblack),
        brightness: Brightness.dark,
      ),
      home: const NavigationPage(),
    );
  }
}
