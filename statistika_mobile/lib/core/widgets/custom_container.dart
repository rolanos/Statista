import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.margin,
    this.shadow,
  });

  final Widget child;

  final EdgeInsets? margin;

  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppConstants.mediumPadding,
        ),
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}
