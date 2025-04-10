import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

class SingleChoiseQuestion extends StatefulWidget {
  const SingleChoiseQuestion({
    super.key,
    required this.question,
    this.availableAnswer,
  });

  final Question question;

  final AvailableAnswer? availableAnswer;

  @override
  State<SingleChoiseQuestion> createState() => _SingleChoiseQuestionState();
}

class _SingleChoiseQuestionState extends State<SingleChoiseQuestion> {
  AvailableAnswer? availableAnswer;

  @override
  void initState() {
    super.initState();
    availableAnswer = widget.availableAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppConstants.largePadding,
      children: [
        Container(
          padding: const EdgeInsets.all(
            AppConstants.mediumPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstants.mediumPadding,
            ),
          ),
          child: Text(
            widget.question.title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.question.availableAnswers.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: AppConstants.mediumPadding),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(
              AppConstants.smallPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppConstants.mediumPadding,
              ),
            ),
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              value: widget.question.availableAnswers[index],
              groupValue: availableAnswer,
              title: Text(
                widget.question.availableAnswers[index].text ?? 'Пустой ответ',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onChanged: (value) => setState(() => availableAnswer = value),
            ),
          ),
        ),
      ],
    );
  }
}
