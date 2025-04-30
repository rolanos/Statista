import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/features/form/view/form_analitic/cubit/form_analitic_cubit.dart';

import 'widget/bar_chart.dart';

class FormAnaliticScreen extends StatefulWidget {
  const FormAnaliticScreen({
    super.key,
    this.formId,
  });

  final String? formId;

  @override
  State<FormAnaliticScreen> createState() => _FormAnaliticScreenState();
}

class _FormAnaliticScreenState extends State<FormAnaliticScreen> {
  final formAnaliticCubit = FormAnaliticCubit();

  @override
  void initState() {
    super.initState();
    formAnaliticCubit.update(widget.formId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => formAnaliticCubit,
      child: BlocBuilder<FormAnaliticCubit, FormAnaliticState>(
        bloc: formAnaliticCubit,
        builder: (context, state) {
          if (state is FormAnaliticLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FormAnaliticInitial) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.questions.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppConstants.smallPadding),
              itemBuilder: (context, index) => BarChartWidget(
                analitic: state.getAnaliticResult(state.questions[index].id),
              ),
              // SingleChoiseQuestion(
              //   question: state.questions[index],
              //   onSelected: (_) {},
              //   analitic: state.getAnaliticResult(
              //     state.questions[index].id,
              //   ),
              // ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
