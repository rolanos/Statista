import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';

import '../../../domain/model/form.dart';

part 'forms_state.dart';

class FormsCubit extends Cubit<FormsState> {
  FormsCubit() : super(FormsLoading());

  void emitRouteArgError() =>
      emit(FormsError(message: 'Ошибка, попробуйте позже'));

  Future<void> getForms() async {
    final result = await FormRepository().getAllForms();
    result.match((e) => emit(FormsError(message: e.toString())),
        (allForms) async {
      final userForms = await FormRepository().getUserForms();
      userForms.match(
        (e) => emit(FormsError(message: e.toString())),
        (userForms) => emit(
          FormsInitial(
            allForms: allForms,
            userForms: userForms,
          ),
        ),
      );
    });
  }
}
