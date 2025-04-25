import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/dto/create_answer/create_answer_request.dart';
import 'package:statistika_mobile/core/model/analitical_complex.dart';
import 'package:statistika_mobile/core/repository/analitical_repository.dart';
import 'package:statistika_mobile/core/repository/answer_repository.dart';
import 'package:statistika_mobile/core/repository/question_repository.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';

import '../../../form/domain/model/question.dart';

part 'general_question_state.dart';

class GeneralQuestionCubit extends Cubit<GeneralQuestionState> {
  GeneralQuestionCubit() : super(GeneralQuestionEmpty());

  Future<void> getGeneralQuestion() async {
    final result = await QuestionRepository().getGeneralQuestion();

    result.match(
      (e) => emit(GeneralQuestionError(message: e.toString())),
      (q) => emit(GeneralQuestionInitial(question: q)),
    );
  }

  Future<void> answerQuestion(AvailableAnswer? answer) async {
    final state = this.state;

    if (state is GeneralQuestionInitial && answer != null) {
      emit(GeneralQuestionInitialAnswerLoading(question: state.question));
      final request = CreateAnswerRequest(
        questionId: state.question.id,
        answerValueId: answer.id,
      );

      final result = await AnswerRepository().sendAnswer(request);

      result.match(
        (e) => emit(GeneralQuestionError(message: e.toString())),
        (_) async {
          final analiticResult =
              await AnaliticalRepository().getAnalitic(state.question.id);

          analiticResult.match(
            (e) => emit(GeneralQuestionError(message: e.toString())),
            (a) => emit(
              GeneralQuestionInitialShowAnalitic(
                question: state.question,
                analitic: a,
              ),
            ),
          );
        },
      );
    }
  }
}
