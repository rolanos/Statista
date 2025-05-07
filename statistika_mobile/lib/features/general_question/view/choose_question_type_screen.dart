import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';

class ChooseQuestionTypeScreen extends StatelessWidget {
  const ChooseQuestionTypeScreen({super.key});

  final list = QuestionTypes.values;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          stretch: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: Text(
            'Профиль',
            style:
                context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Wrap(
              runSpacing: AppConstants.smallPadding,
              spacing: AppConstants.smallPadding,
              children: List.generate(
                list.length,
                (i) => GestureDetector(
                  onTap: () => context.goNamed(
                    NavigationRoutes.createGeneralQuestion,
                    queryParameters: {'type': list[i].id},
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.mediumPadding),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius:
                          BorderRadius.circular(AppConstants.mediumPadding),
                    ),
                    child: Text(
                      list[i].name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
