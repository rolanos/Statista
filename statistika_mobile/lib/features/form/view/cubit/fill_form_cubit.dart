import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/model/create_answer_request.dart';
import 'package:statistika_mobile/features/form/data/repository/section_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
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

  void nextQuestion(CreateAnswerRequest answer) {
    final state = this.state;
    if (state is FillFormInitial) {
      updateAnswer(answer);
      final currentIndex = state.currentSection.questions
          .indexWhere((q) => q.id == state.currentQuestion.id);
      if (currentIndex != -1 &&
          currentIndex < state.currentSection.questions.length - 1) {
        emit(
          state.copyWith(
            currentQuestion: state.currentSection.questions[currentIndex + 1],
          ),
        );
      }
    }
  }

  void pastQuestion() {
    final state = this.state;
    if (state is FillFormInitial) {
      final currentIndex = state.currentSection.questions
          .indexWhere((q) => q.id == state.currentQuestion.id);
      if (currentIndex > 0) {
        emit(
          state.copyWith(
            currentQuestion: state.currentSection.questions[currentIndex - 1],
          ),
        );
      }
    }
  }

  void updateAnswer(CreateAnswerRequest answer) {
    final state = this.state;
    if (state is FillFormInitial) {
      final answersCopy = List<CreateAnswerRequest>.from(state.answers);
      for (var value in answersCopy) {
        if (answer.questionId == value.questionId) {
          answersCopy.removeWhere((a) => answer.questionId == value.questionId);
          answersCopy.add(answer);
          emit(state.copyWith(answers: answersCopy));
          break;
        }
      }
    }
  }

  AvailableAnswer? getAnswer(Question question) {
    final state = this.state;
    if (state is FillFormInitial) {
      final answersCopy = List<CreateAnswerRequest>.from(state.answers);
      for (var value in answersCopy) {
        if (question.id == value.questionId) {
          final answer = question.availableAnswers
              .where((a) => a.id == value.answerValueId)
              .toList();
          if (answer.isNotEmpty) {
            return answer.first;
          }
        }
      }
    }
  }
}
