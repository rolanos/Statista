part of 'form_cubit.dart';

@immutable
sealed class FormsState {}

final class FormsLoading extends FormsState {}

final class FormsError extends FormsState {
  FormsError({required this.message});

  final String message;
}

final class FormsInitial extends FormsState {
  FormsInitial({this.forms = const []});

  final List<Form> forms;
}
