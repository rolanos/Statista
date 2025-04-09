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
  });

  final List<Section> sections;
  final Section currentSection;
  final Question currentQuestion;
}
