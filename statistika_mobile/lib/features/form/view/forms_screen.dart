import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/constants.dart';

import 'widget/form_card.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.mediumPadding),
      child: Column(
        spacing: AppConstants.mediumPadding,
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.mediumPadding,
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Поиск',
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 10,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.mediumPadding,
                vertical: AppConstants.mediumPadding,
              ),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppConstants.mediumPadding),
              itemBuilder: (context, index) => const FormCard(),
            ),
          ),
        ],
      ),
    );
  }
}
