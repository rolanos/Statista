import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/user_profile_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationInited) {
          context.read<UserProfileCubit>().init(state.user);
          context.goNamed(NavigationRoutes.generalQuestions);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                      'Имя',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: context.textTheme.bodySmall,
                      decoration: const InputDecoration(
                        hintText: 'Введите имя',
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: AppConstants.smallPadding,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Email',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.gray,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      style: context.textTheme.bodySmall,
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
                    RichText(
                      text: TextSpan(
                        text: 'Пароль',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.gray,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: context.textTheme.bodySmall,
                      decoration: const InputDecoration(
                        hintText: 'Введите пароль',
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AuthorizationCubit, AuthorizationState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthorizationCubit>().register(
                              emailController.text,
                              passwordController.text,
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is AuthorizationLoading)
                            SizedBox(
                              height: (context.textTheme.bodyMedium?.fontSize ??
                                      12) *
                                  (context.textTheme.bodyMedium?.height ?? 1),
                              width: (context.textTheme.bodyMedium?.fontSize ??
                                      12) *
                                  (context.textTheme.bodyMedium?.height ?? 1),
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            ),
                          if (state is! AuthorizationLoading)
                            Text(
                              'Регистрация',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
