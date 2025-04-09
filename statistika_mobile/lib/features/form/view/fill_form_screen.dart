import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/features/form/view/cubit/fill_form_cubit.dart';

class FillFormScreen extends StatelessWidget {
  const FillFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FillFormCubit, FillFormState>(
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
