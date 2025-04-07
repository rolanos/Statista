import 'package:flutter/material.dart';
import 'package:statistika_mobile/features/form/view/forms_screen.dart';

import '../../core/constants/constants.dart';
import '../survey/view/survey_screen.dart' show SurveyScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final _children = [
    const SurveyScreen(),
    const FormsScreen(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _children[currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: AppTheme.smallShadows,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Вопросы',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Анкеты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
