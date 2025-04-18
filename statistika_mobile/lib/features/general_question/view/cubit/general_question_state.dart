part of 'general_question_cubit.dart';

@immutable
sealed class GeneralQuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GeneralQuestionEmpty extends GeneralQuestionState {}

final class GeneralQuestionLoading extends GeneralQuestionState {}

final class GeneralQuestionError extends GeneralQuestionState {
  GeneralQuestionError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class GeneralQuestionInitial extends GeneralQuestionState {
  GeneralQuestionInitial({required this.question});

  final Question question;

  @override
  List<Object?> get props => [question];
}
