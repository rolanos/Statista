import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/data/model/create_answer_request.dart';
import 'package:statistika_mobile/features/form/view/cubit/active_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/cubit/fill_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/widget/questions/single_choise_question.dart';

class FillFormScreen extends StatelessWidget {
  const FillFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<ActiveFormCubit, ActiveFormState>(
                builder: (context, state) {
                  return Text(
                    state.form?.name ?? '',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<FillFormCubit, FillFormState>(
              builder: (context, state) {
                if (state is FillFormInitial) {
                  return SingleChoiseQuestion(
                    question: state.currentQuestion,
                    availableAnswer: context
                        .read<FillFormCubit>()
                        .getAnswer(state.currentQuestion),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<FillFormCubit>().pastQuestion();
                },
                child: Text(
                  'Назад',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // context.read<FillFormCubit>().nextQuestion(
                  //       CreateAnswerRequest(
                  //         questionId: questionId,
                  //         answerValueId: answerValueId,
                  //       ),
                  //     );
                },
                child: Text(
                  'Ответить',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
