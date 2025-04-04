import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.largePadding),
          child: Column(
            spacing: AppConstants.mediumPadding,
            children: [
              const Spacer(),
              Text(
                'Survey App',
                style: context.textTheme.titleLarge,
              ),
              Column(
                spacing: AppConstants.smallPadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Введите почту',
                    ),
                  ),
                ],
              ),
              Column(
                spacing: AppConstants.smallPadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Пароль',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Введите пароль',
                    ),
                  ),
                  Text(
                    'Забыли пароль?',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
              const SizedBox(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Войти',
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
