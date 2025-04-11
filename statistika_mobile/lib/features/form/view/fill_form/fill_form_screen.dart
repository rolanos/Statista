import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/data/model/create_answer_request.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/active_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/cubit/fill_form/fill_form_cubit.dart';
import 'package:statistika_mobile/features/form/view/fill_form/widget/questions/single_choise_question.dart';

class FillFormScreen extends StatelessWidget {
  const FillFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FillFormCubit, FillFormState>(
      listener: (context, state) {
        if (state is FillFormSended) {
          context.goNamed(NavigationRoutes.endForm);
        }
      },
      child: Padding(
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
                      onSelected: (ans) {
                        if (ans != null) {
                          context.read<FillFormCubit>().updateAnswer(
                                CreateAnswerRequest(
                                  questionId: state.currentQuestion.id,
                                  answerValueId: ans.id,
                                ),
                              );
                        }
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            BlocBuilder<FillFormCubit, FillFormState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (state is FillFormInitial && state.isFirstQuestion) {
                          context.pop();
                        } else {
                          context.read<FillFormCubit>().pastQuestion();
                        }
                      },
                      child: Text(
                        'Назад',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (state is FillFormInitial && state.isLastQuestion) {
                          await context.read<FillFormCubit>().sendForm();
                        } else {
                          context.read<FillFormCubit>().nextQuestion();
                        }
                      },
                      child: Text(
                        state is FillFormInitial && state.isLastQuestion
                            ? 'Отправить форму'
                            : 'Ответить',
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
