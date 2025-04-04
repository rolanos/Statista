import 'package:flutter/material.dart';
import 'package:statistika_mobile/features/home/home_screen.dart';

import 'core/constants/constants.dart';
import 'features/authorization/view/authorization_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthorizationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
