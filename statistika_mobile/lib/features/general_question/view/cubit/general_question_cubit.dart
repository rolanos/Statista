import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/core/repository/question_repository.dart';

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
}
