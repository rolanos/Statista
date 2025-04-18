import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/general_question/view/cubit/general_question_cubit.dart';

import '../../../core/widgets/questions/single_choise_question.dart';

class GeneralQuestionScreen extends StatefulWidget {
  const GeneralQuestionScreen({super.key});

  @override
  State<GeneralQuestionScreen> createState() => _GeneralQuestionScreenState();
}

class _GeneralQuestionScreenState extends State<GeneralQuestionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GeneralQuestionCubit>().getGeneralQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<GeneralQuestionCubit>().getGeneralQuestion(),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          context
                              .goNamed(NavigationRoutes.createGeneralQuestion);
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child:
                        BlocBuilder<GeneralQuestionCubit, GeneralQuestionState>(
                      builder: (context, state) {
                        if (state is GeneralQuestionLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is GeneralQuestionInitial) {
                          return Center(
                            child: SingleChoiseQuestion(
                              question: state.question,
                              onSelected: (a) {},
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
