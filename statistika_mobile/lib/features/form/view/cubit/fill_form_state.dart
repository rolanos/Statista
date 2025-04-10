part of 'fill_form_cubit.dart';

@immutable
sealed class FillFormState {}

final class FillFormEmpty extends FillFormState {}

final class FillFormLoading extends FillFormState {}

final class FillFormSended extends FillFormState {}

final class FillFormError extends FillFormState {
  FillFormError({required this.message});

  final String message;
}

final class FillFormInitial extends FillFormState {
  FillFormInitial({
    required this.sections,
    required this.currentSection,
    required this.currentQuestion,
    this.answers = const [],
  });

  final List<Section> sections;

  final Section currentSection;
  final Question currentQuestion;

  final List<CreateAnswerRequest> answers;

  FillFormInitial copyWith({
    List<Section>? sections,
    Section? currentSection,
    Question? currentQuestion,
    List<CreateAnswerRequest>? answers,
  }) {
    return FillFormInitial(
      sections: sections ?? this.sections,
      currentSection: currentSection ?? this.currentSection,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answers: answers ?? this.answers,
    );
  }
}
