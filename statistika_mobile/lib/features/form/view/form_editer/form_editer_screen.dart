import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/view/form_editer/cubit/form_editer_cubit.dart';

import 'widget/section_content.dart';

class FormEditerScreen extends StatefulWidget {
  const FormEditerScreen({
    super.key,
    this.formId,
  });

  final String? formId;

  @override
  State<FormEditerScreen> createState() => _FormEditerScreenState();
}

class _FormEditerScreenState extends State<FormEditerScreen> {
  final formEditerCubit = FormEditerCubit();

  @override
  void initState() {
    super.initState();
    formEditerCubit.update(formId: widget.formId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => formEditerCubit,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: BlocBuilder<FormEditerCubit, FormEditerState>(
          bloc: formEditerCubit,
          builder: (context, state) {
            if (state is FormEditerInitial) {
              return PageView.builder(
                itemCount: state.sections.length,
                itemBuilder: (context, index) => RefreshIndicator(
                  onRefresh: () => formEditerCubit.update(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.sections[index].title ??
                                    'Пустой заголовок',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.black),
                              ),
                              if (state is FormEditerInitialLoading)
                                Text(
                                  'Сохранение..',
                                  style: context.textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.black),
                                ),
                              IconButton(
                                onPressed: () {
                                  formEditerCubit.addNewQuestion(
                                    state.sections[index],
                                    'Пустой заголовок',
                                  );
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          SectionContent(section: state.sections[index]),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => formEditerCubit.update(formId: widget.formId),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
