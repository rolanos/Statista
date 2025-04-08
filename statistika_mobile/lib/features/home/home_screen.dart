import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/features/form/view/forms_screen.dart';

import '../../core/constants/constants.dart';
import '../survey/view/survey_screen.dart' show SurveyScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: AppTheme.smallShadows,
        ),
        child: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (value) {
            widget.navigationShell.goBranch(
              value,
              initialLocation: value == widget.navigationShell.currentIndex,
            );
            setState(() {});
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
