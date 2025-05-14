import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';

import '../../core/constants/constants.dart';

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
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: showBottomNavigationBar()
          ? Container(
              decoration: BoxDecoration(
                boxShadow: AppTheme.smallShadows,
              ),
              child: BottomNavigationBar(
                currentIndex: widget.navigationShell.currentIndex,
                onTap: (value) {
                  widget.navigationShell.goBranch(
                    value,
                    initialLocation:
                        value == widget.navigationShell.currentIndex,
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
                    label: 'Опросы',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Профиль',
                  ),
                ],
              ),
            )
          : null,
    );
  }

  bool showBottomNavigationBar() {
    final splitted = GoRouterState.of(context).uri.toString().split('/');
    if (splitted.isNotEmpty) {
      final last = splitted.last;
      switch (last) {
        case NavigationRoutes.welcomeForm ||
              NavigationRoutes.fillForm ||
              NavigationRoutes.endForm:
          return false;
      }
    }
    return true;
  }
}
