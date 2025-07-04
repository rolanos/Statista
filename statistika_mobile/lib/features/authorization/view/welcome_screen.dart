import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.network(
                  'https://lottie.host/8104afa2-4d27-4a3f-8d04-75a73240e3bd/ukdDJGJ6VU.json',
                  repeat: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: Column(
                spacing: AppConstants.mediumPadding,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed(NavigationRoutes.auth);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Авторизация',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      shadowColor: WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () async {
                      await SharedPreferencesManager.clear();
                      if (context.mounted) {
                        context.goNamed(NavigationRoutes.generalQuestions);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Анонимный вход',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
