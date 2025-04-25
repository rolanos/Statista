import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/core/widgets/questions_create_template/single_choise_create.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/create_question_cubit.dart';

import '../../../core/constants/app_constants.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final createQuestionCubit = CreateQuestionCubit()
    ..init(QuestionTypes.singleChoise.id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createQuestionCubit,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            title: Text('Создание вопроса'),
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
                  return Column(
                    spacing: AppConstants.largePadding,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChoiseCreateWidget(
                        question: state.question,
                        onUpdateTitle: (title) =>
                            createQuestionCubit.changeQuestionTitle(title),
                        onAddAnswer: () => createQuestionCubit.addAnswer(),
                        onUpdateAvailableAnswer: (answer, text) =>
                            createQuestionCubit.updateAnswer(
                          answer,
                          text,
                        ),
                        onDeleteAvailableAnswer: (answer) =>
                            createQuestionCubit.deleteAnswer(answer),
                      ),
                      if (createQuestionCubit.canCreateQuestion())
                        ElevatedButton(
                          onPressed: () => createQuestionCubit.addNewQuestion(),
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
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                            ],
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
    );
  }
}
