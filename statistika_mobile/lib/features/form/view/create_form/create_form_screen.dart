import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/model/classifier.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/user_profile_cubit.dart';
import 'package:statistika_mobile/features/form/view/create_form/cubit/create_form_cubit.dart';
import 'package:statistika_mobile/features/home/cubit/survey_types_cubit.dart';

import '../../../../core/widgets/custom_container.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final createFormCubit = CreateFormCubit();

  Classifier? type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createFormCubit,
      child: BlocListener<CreateFormCubit, CreateFormState>(
        bloc: createFormCubit,
        listener: (context, state) {
          if (state is CreateFormCreated) {
            context.goNamed(
              NavigationRoutes.formEditer,
              queryParameters: {
                'formId': state.form.id,
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: Column(
            spacing: AppConstants.mediumPadding,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Создание новой анкеты',
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              CustomContainer(
                child: Column(
                  spacing: AppConstants.smallPadding,
                  children: [
                    BlocBuilder<SurveyTypesCubit, SurveyTypesState>(
                      builder: (context, state) {
                        return DropdownButton<Classifier>(
                          isExpanded: true,
                          value: type,
                          hint: const Text(
                            'Тип анкеты',
                          ),
                          underline: const SizedBox(),
                          style: context.textTheme.bodyMedium,
                          items: state is SurveyTypesInitial
                              ? List.generate(
                                  state.types.length,
                                  (i) => DropdownMenuItem(
                                    value: state.types[i],
                                    child: Row(
                                      children: [Text(state.types[i].name)],
                                    ),
                                  ),
                                )
                              : [],
                          onChanged: (value) => setState(
                            () => type = value,
                          ),
                        );
                      },
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Название',
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Описание',
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (state is UserProfileInitial &&
                          nameController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        await createFormCubit.createForm(
                          nameController.text,
                          descriptionController.text,
                          state.user.id,
                          type?.id,
                        );
                      }
                    },
                    child: BlocBuilder<CreateFormCubit, CreateFormState>(
                      bloc: createFormCubit,
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is CreateFormCubit)
                              const CircularProgressIndicator(),
                            if (state is! CreateFormCubit)
                              Text(
                                'Создать форму',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
