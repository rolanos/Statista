import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/general_question_cubit.dart';

import '../../../core/widgets/questions/single_choise_question.dart';
import '../../form/domain/model/available_answer.dart';

class GeneralQuestionScreen extends StatefulWidget {
  const GeneralQuestionScreen({super.key});

  @override
  State<GeneralQuestionScreen> createState() => _GeneralQuestionScreenState();
}

class _GeneralQuestionScreenState extends State<GeneralQuestionScreen> {
  AvailableAnswer? answer;

  @override
  void initState() {
    super.initState();
    context.read<GeneralQuestionCubit>().getGeneralQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<GeneralQuestionCubit>().getGeneralQuestion(),
      notificationPredicate: (notification) {
        return notification.depth == 1;
      },
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: true,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            title: Text(
              'Вопросы',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.goNamed(NavigationRoutes.chooseQuestionType);
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ],
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<GeneralQuestionCubit, GeneralQuestionState>(
                  listenWhen: (previous, current) {
                    if (previous is GeneralQuestionInitial &&
                        current is GeneralQuestionInitial) {
                      return previous.question != current.question;
                    }
                    return false;
                  },
                  listener: (context, state) {
                    if (state is GeneralQuestionInitial) {
                      answer = null;
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    if (state is GeneralQuestionLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is GeneralQuestionInitial) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppConstants.mediumPadding,
                        children: [
                          SingleChoiseQuestion(
                            question: state.question,
                            onSelected: (a) => answer = a,
                            analitic:
                                state is GeneralQuestionInitialShowAnalitic
                                    ? state.analitic
                                    : null,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: AppConstants.mediumPadding,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (state
                                      is GeneralQuestionInitialAnswerLoading) {
                                    return;
                                  } else if (state
                                      is GeneralQuestionInitialShowAnalitic) {
                                    await context
                                        .read<GeneralQuestionCubit>()
                                        .getGeneralQuestion();
                                  } else if (answer != null) {
                                    await context
                                        .read<GeneralQuestionCubit>()
                                        .answerQuestion(answer);
                                  }
                                },
                                child:
                                    state is GeneralQuestionInitialAnswerLoading
                                        ? const CircularProgressIndicator(
                                            color: AppColors.white,
                                          )
                                        : Text(
                                            state is GeneralQuestionInitialShowAnalitic
                                                ? 'Следующий вопрос'
                                                : 'Ответить',
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
