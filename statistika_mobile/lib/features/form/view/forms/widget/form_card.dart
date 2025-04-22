import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';

import '../../../domain/model/form.dart' as f;

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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(
                      NavigationRoutes.formEditer,
                      queryParameters: {'formId': form.id},
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(
                      NavigationRoutes.formAnalitic,
                      queryParameters: {'formId': form.id},
                    );
                  },
                  child: const Icon(
                    Icons.analytics,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward,
                ),
              ],
            ),
            Text(form.name),
            Text(form.description),
            Row(
              children: [
                Flexible(child: Text(form.createdById)),
                Flexible(child: Text(form.createdDate.toString())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
