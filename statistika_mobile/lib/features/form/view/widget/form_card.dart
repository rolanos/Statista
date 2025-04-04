import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';

class FormCard extends StatelessWidget {
  const FormCard({super.key});

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
      child: const Column(
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
          Text('Customer Experience Survey'),
          Text('Share your feedback about our service quality'),
        ],
      ),
    );
  }
}
