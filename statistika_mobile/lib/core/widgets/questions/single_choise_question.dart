import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/model/analitical_complex.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../../constants/theme.dart';

class SingleChoiseQuestion extends StatefulWidget {
  const SingleChoiseQuestion({
    super.key,
    required this.question,
    required this.onSelected,
    this.analitic,
    this.availableAnswer,
  });

  final Question question;

  final AvailableAnswer? availableAnswer;

  final AnaliticComplexResult? analitic;

  final Function(AvailableAnswer?) onSelected;

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
    return Container(
      margin: const EdgeInsets.all(AppConstants.mediumPadding),
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppTheme.smallShadows,
        borderRadius: BorderRadius.circular(AppConstants.mediumPadding),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.question.availableAnswers.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppConstants.mediumPadding),
            itemBuilder: (context, index) => Builder(builder: (context) {
              final analiticResult = widget.analitic?.findByAnswerIdSingle(
                widget.question.availableAnswers[index].id,
              );
              return Container(
                padding: const EdgeInsets.all(
                  AppConstants.smallPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.mediumPadding,
                  ),
                ),
                child: Column(
                  spacing: AppConstants.smallPadding,
                  children: [
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      value: widget.question.availableAnswers[index],
                      groupValue: availableAnswer,
                      title: Text(
                        widget.question.availableAnswers[index].text ??
                            'Пустой ответ',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        widget.onSelected(value);
                        setState(() => availableAnswer = value);
                      },
                    ),
                    if (widget.analitic != null &&
                        analiticResult != null &&
                        widget.analitic?.totalCount != null &&
                        widget.analitic?.totalCount != 0)
                      LinearProgressIndicator(
                        value: analiticResult.count /
                            (widget.analitic?.totalCount ?? 1),
                        backgroundColor: AppColors.whiteSecondary,
                        borderRadius: BorderRadius.circular(
                          AppConstants.miniPadding,
                        ),
                        minHeight: 6,
                      ),
                    if (widget.analitic != null &&
                        analiticResult != null &&
                        widget.analitic?.totalCount != null &&
                        widget.analitic?.totalCount != 0)
                      Row(
                        children: [
                          Text(
                            '${analiticResult.count}/${widget.analitic?.totalCount ?? 1}',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.gray),
                          ),
                          const Spacer(),
                          Text(
                            '${(100 * (analiticResult.count / (widget.analitic?.totalCount ?? 1))).toStringAsFixed(0)}%',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
