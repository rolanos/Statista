import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/questions_create_template/single_choise_create.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/create_question_cubit.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/questions_create_template/multiple_choise_create.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key, this.type});

  final String? type;

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final createQuestionCubit = CreateQuestionCubit();

  late final QuestionTypes? type;

  @override
  void initState() {
    super.initState();
    type = QuestionTypes.tryParse(widget.type);

    createQuestionCubit.init(type?.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createQuestionCubit,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            title: Text(
              'Создание вопроса',
              style:
                  context.textTheme.bodyLarge?.copyWith(color: AppColors.black),
            ),
          ),
          SliverFillRemaining(
            child: BlocConsumer<CreateQuestionCubit, CreateQuestionState>(
              bloc: createQuestionCubit,
              listener: (context, state) {
                if (state is CreateQuestionSendSuccess) {
                  context.goNamed(NavigationRoutes.generalQuestions);
                }
              },
              builder: (context, state) {
                if (state is CreateQuestionInitial) {
                  return Padding(
                    padding: const EdgeInsets.all(AppConstants.mediumPadding),
                    child: Column(
                      spacing: AppConstants.largePadding,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        switch (type) {
                          QuestionTypes.singleChoise =>
                            SingleChoiseCreateWidget(
                              question: state.question,
                              onUpdateTitle: (title) => createQuestionCubit
                                  .changeQuestionTitle(title),
                              onAddAnswer: () =>
                                  createQuestionCubit.addAnswer(),
                              onUpdateAvailableAnswer: (answer, text) =>
                                  createQuestionCubit.updateAnswer(
                                answer,
                                text,
                              ),
                              onDeleteAvailableAnswer: (answer) =>
                                  createQuestionCubit.deleteAnswer(answer),
                              duration: Duration.zero,
                            ),
                          QuestionTypes.multipleChoice =>
                            MultipleChoiseCreateWidget(
                              question: state.question,
                              onUpdateTitle: (title) => createQuestionCubit
                                  .changeQuestionTitle(title),
                              onAddAnswer: () =>
                                  createQuestionCubit.addAnswer(),
                              onUpdateAvailableAnswer: (answer, text) =>
                                  createQuestionCubit.updateAnswer(
                                answer,
                                text,
                              ),
                              onDeleteAvailableAnswer: (answer) =>
                                  createQuestionCubit.deleteAnswer(answer),
                              duration: Duration.zero,
                            ),
                          null => const SizedBox(),
                        },
                        if (createQuestionCubit.canCreateQuestion())
                          ElevatedButton(
                            onPressed: () =>
                                createQuestionCubit.addNewQuestion(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is CreateQuestionSendLoading)
                                  const CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                if (state is! CreateQuestionSendLoading)
                                  Text(
                                    'Создать',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
