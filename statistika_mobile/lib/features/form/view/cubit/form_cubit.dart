import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';

import '../../domain/model/form.dart';

part 'form_state.dart';

class FormsCubit extends Cubit<FormsState> {
  FormsCubit() : super(FormsLoading());

  void emitRouteArgError() =>
      emit(FormsError(message: 'Ошибка, попробуйте позже'));

  Future<void> getFormsBySurvey(String surveyId) async {
    if (surveyId.isEmpty) {
      emit(FormsInitial());
    }
    final result = await FormRepository().getFormsBySurveyId(surveyId);
    result.match(
      (e) => emit(FormsError(message: e.toString())),
      (list) => emit(
        FormsInitial(forms: list),
      ),
    );
  }
}
