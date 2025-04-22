import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/model/analitical_complex.dart';
import 'package:statistika_mobile/core/repository/analitical_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

part 'form_analitic_state.dart';

class FormAnaliticCubit extends Cubit<FormAnaliticState> {
  FormAnaliticCubit() : super(FormAnaliticEmpty());

  Future<void> update(String? formId) async {
    if (formId == null) {
      emit(FormAnaliticError(message: 'Ошибка! Попробуйте позже'));
      return;
    }
    emit(FormAnaliticLoading());

    final sections = await SectionRepository().getSections(formId);

    sections.match(
      (e) => emit(FormAnaliticError(message: e.toString())),
      (s) async {
        if (s.isNotEmpty) {
          final section = s.first;
          final analiticList = <AnaliticComplexResult>[];
          await for (final question in Stream.fromIterable(section.questions)) {
            final analiticByQuestion =
                await AnaliticalRepository().getAnalitic(question.id);

            analiticByQuestion.match(
              (e) {},
              (a) => analiticList.add(a),
            );
          }
          emit(
            FormAnaliticInitial(
              formId: formId,
              analitics: analiticList,
              questions: section.questions,
            ),
          );
        }
      },
    );
  }
}
