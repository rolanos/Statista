import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/widgets/questions_create_template/single_choise_create.dart';
import 'package:statistika_mobile/core/widgets/questions/single_choise_question.dart';

import '../../../core/constants/app_constants.dart';
import '../../form/domain/model/question.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  Question question = Question.empty();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          snap: false,
          pinned: true,
          floating: false,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          title: Text('Создание вопроса'),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          sliver: SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChoiseCreateWidget(
                  question: question,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
