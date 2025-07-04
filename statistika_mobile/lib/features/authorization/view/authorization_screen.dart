import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/snack_bar.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/user_profile_cubit.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationInited) {
          context.read<UserProfileCubit>().init(state.user);
          context.goNamed(NavigationRoutes.generalQuestions);
        }
        if (state is AuthorizationError) {
          showCustomSnackBar(context, state.message);
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
                  'Авторизация',
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
                    Text(
                      'Пароль',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      style: context.textTheme.bodySmall,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.black,
                          ),
                        ),
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
                BlocBuilder<AuthorizationCubit, AuthorizationState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthorizationCubit>().login(
                            emailController.text, passwordController.text);
                        // Navigator.of(context).pushNamed('/home');
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
                              'Войти',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                    shadowColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    context.goNamed(NavigationRoutes.register);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Зарегестрироваться',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
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
