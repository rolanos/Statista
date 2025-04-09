import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/form/view/cubit/active_form_cubit.dart';

import '../../domain/model/form.dart' as f;

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.form,
  });

  final f.Form form;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ActiveFormCubit>().init(form);
        context.pushNamed(NavigationRoutes.welcomeForm);
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: AppTheme.smallShadows,
          borderRadius: BorderRadius.circular(
            AppConstants.smallPadding,
          ),
        ),
        child: Column(
          spacing: AppConstants.smallPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                ),
              ],
            ),
            Text(form.id),
            Text(form.name),
          ],
        ),
      ),
    );
  }
}
