import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';

import '../../../../core/constants/routes.dart';

class WelcomeFormScreen extends StatefulWidget {
  const WelcomeFormScreen({super.key});

  @override
  State<WelcomeFormScreen> createState() => _WelcomeFormScreenState();
}

class _WelcomeFormScreenState extends State<WelcomeFormScreen> {
  final fillFormCubit = FillFormCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => fillFormCubit,
      child: BlocConsumer<FillFormCubit, FillFormState>(
        bloc: fillFormCubit,
        listener: (context, state) {
          if (state is FillFormInitial) {
            context.goNamed(NavigationRoutes.fillForm, extra: fillFormCubit);
          }
        },
        builder: (context, fillFormState) {
          return BlocBuilder<ActiveFormCubit, ActiveFormState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: AppConstants.smallPadding,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: context.mediaQuerySize.height * 0.22,
                      ),
                      child: Lottie.network(
                        'https://lottie.host/ce90a354-6bc3-4e72-87d1-efeed8e12d29/AXjqZXNYNJ.json',
                      ),
                    ),
                    Text(
                      state.form?.name ?? '',
                      style: context.textTheme.titleLarge!.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await fillFormCubit.start(state.form?.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (fillFormState is FillFormLoading)
                            const CircularProgressIndicator(
                                color: AppColors.white),
                          if (fillFormState is! FillFormLoading)
                            Text(
                              'Начать анкету',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
