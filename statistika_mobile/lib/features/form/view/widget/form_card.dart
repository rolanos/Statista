import 'package:flutter/material.dart';

import 'package:statistika_mobile/core/constants/constants.dart';

import '../../domain/model/form.dart' as f;

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.form,
  });

  final f.Form form;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
