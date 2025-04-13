import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/model/create_question_request.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/question_repository.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';

part 'form_editer_state.dart';

class FormEditerCubit extends Cubit<FormEditerState> {
  FormEditerCubit() : super(FormEditerLoading());

  ///обновляем модель Form
  Future<void> update({String? formId}) async {
    if (formId == null || formId.isEmpty) {
      if (state.form?.id != null) {
        formId = state.form?.id;
      }
      if (formId == null) {
        emit(FormEditerError(message: 'Ошибка'));
        return;
      }
    }

    final form = await FormRepository().getFormById(formId);

    form.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) => emit(FormEditerInitial(f)),
    );
  }

  //Добавляем новый вопрос в список вопросов
  Future<void> addNewQuestion(String title) async {
    final createRequest = CreateQuestionRequest(
      title: title,
      pastQuestion: null,
      nextQuestion: null,
      typeId: QuestionTypes.singleChoise.id,
      sectionId: null,
    );
    final result = await QuestionRepository().createQuestion(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //TODO обновляем вопрос
  Future<void> updateQuestion() async {}

  //TODO удаляем вопрос
  Future<void> deleteQuestion() async {}
}
