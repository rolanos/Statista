import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';

part 'fill_form_state.dart';

class FillFormCubit extends Cubit<FillFormState> {
  FillFormCubit() : super(FillFormEmpty());

  Future<void> start(String? formId) async {
    if (formId == null || formId.isEmpty) {
      emit(FillFormError(message: 'Ошибка, попробуйте позже'));
      return;
    }
    emit(FillFormLoading());
    final sections = await SectionRepository().getSections(formId);
    sections.match(
      (e) => emit(FillFormError(message: e.toString())),
      (list) {
        if (list.isEmpty) {
          emit(FillFormError(message: 'Ошибка, анкета пуста'));
          return;
        }
        if (list.first.questions.isNotEmpty) {
          emit(
            FillFormInitial(
              sections: list,
              currentSection: list.first,
              currentQuestion: list.first.questions.first,
            ),
          );
        } else {
          emit(FillFormError(message: 'Ошибка, секция пуста'));
        }
      },
    );
  }
}
