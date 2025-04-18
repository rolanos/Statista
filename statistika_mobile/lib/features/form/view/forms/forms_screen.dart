import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
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
    return BlocProvider(
      create: (context) => formsCubit,
      child: RefreshIndicator(
        onRefresh: () async => formsCubit.getForms(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              backgroundColor: AppColors.white,
              surfaceTintColor: AppColors.white,
              actions: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.goNamed(NavigationRoutes.createForm);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                spacing: AppConstants.mediumPadding,
                children: [
                  BlocBuilder<FormsCubit, FormsState>(
                    builder: (context, state) {
                      if (state is FormsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is FormsInitial) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.forms.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.mediumPadding,
                            vertical: AppConstants.mediumPadding,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                              height: AppConstants.mediumPadding),
                          itemBuilder: (context, index) => FormCard(
                            form: state.forms[index],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
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
