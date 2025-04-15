import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/model/create_question_request.dart';
import 'package:statistika_mobile/features/form/data/repository/available_answer_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/question_repository.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/enum/question_types.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';
import 'package:statistika_mobile/features/form/domain/model/section.dart';

import '../../../data/model/create_available_answer_request.dart';

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
      (f) async {
        emit(FormEditerInitial(form: f));
        final sectionsResult = await SectionRepository().getSections(f.id);
        sectionsResult.match(
          (e) => emit(FormEditerError(message: e.toString())),
          (s) => emit(FormEditerInitial(form: f, sections: s)),
        );
      },
    );
  }

  //Добавляем новый вопрос в список вопросов
  Future<void> addNewQuestion(Section section, String title) async {
    final createRequest = CreateQuestionRequest(
      title: title,
      pastQuestion: null,
      nextQuestion: null,
      typeId: QuestionTypes.singleChoise.id,
      sectionId: section.id,
    );
    final result = await QuestionRepository().createQuestion(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //TODO обновляем вопрос
  Future<void> updateQuestion() async {}

  Future<void> addAvailableAnswer(Question question) async {
    final createRequest = CreateAvailableAnswerRequest(
      questionId: question.id,
      text: 'Пустой ответ',
      imageLink: null,
    );

    final result =
        await AvailableAnswerRepository().createAnswer(createRequest);

    result.match(
      (e) => emit(FormEditerError(message: e.toString())),
      (f) async => update(),
    );
  }

  //TODO удаляем вопрос
  Future<void> deleteQuestion() async {}
}
