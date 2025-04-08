import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/features/form/view/cubit/form_cubit.dart';

import 'widget/form_card.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({
    super.key,
    this.surveyId,
  });

  final String? surveyId;

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final formsCubit = FormsCubit();

  @override
  void initState() {
    super.initState();
    if (widget.surveyId != null) {
      formsCubit.getFormsBySurvey(widget.surveyId as String);
    } else {
      formsCubit.emitRouteArgError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => formsCubit,
      child: Padding(
        padding: const EdgeInsets.only(top: AppConstants.mediumPadding),
        child: Column(
          spacing: AppConstants.mediumPadding,
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.mediumPadding,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Поиск',
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FormsCubit, FormsState>(
                builder: (context, state) {
                  if (state is FormsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FormsInitial) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mediumPadding,
                        vertical: AppConstants.mediumPadding,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppConstants.mediumPadding),
                      itemBuilder: (context, index) => const FormCard(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
