import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/utils.dart';
import 'package:statistika_mobile/features/form/view/forms/cubit/forms_cubit.dart';

import 'widget/form_card.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({
    super.key,
  });

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final formsCubit = FormsCubit();

  @override
  void initState() {
    super.initState();
    formsCubit.getForms();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => formsCubit,
        child: RefreshIndicator(
          notificationPredicate: (notification) {
            return notification.depth == 2;
          },
          onRefresh: () async => formsCubit.getForms(),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                snap: false,
                pinned: true,
                floating: true,
                backgroundColor: AppColors.white,
                surfaceTintColor: AppColors.white,
                title: Text(
                  'Опросы',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: AppColors.black),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(NavigationRoutes.createForm);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
                bottom: const TabBar(
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(
                      text: 'Все опросы',
                    ),
                    Tab(
                      text: 'Мои опросы',
                    ),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              children: [
                BlocBuilder<FormsCubit, FormsState>(
                  builder: (context, state) {
                    if (state is FormsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is FormsInitial) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.allForms.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.mediumPadding,
                          vertical: AppConstants.mediumPadding,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppConstants.mediumPadding),
                        itemBuilder: (context, index) => FormCard(
                          form: state.allForms[index],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<FormsCubit, FormsState>(
                  builder: (context, state) {
                    if (state is FormsInitial) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.userForms.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.mediumPadding,
                          vertical: AppConstants.mediumPadding,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppConstants.mediumPadding),
                        itemBuilder: (context, index) => FormCard(
                          form: state.userForms[index],
                          mode: FormCardViewMode.admin,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
