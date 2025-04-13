part of 'form_editer_cubit.dart';

@immutable
sealed class FormEditerState {
  abstract final Form? form;
}

final class FormEditerLoading extends FormEditerState {
  @override
  Form? get form => null;
}

final class FormEditerError extends FormEditerState {
  FormEditerError({required this.message});

  final String message;

  @override
  Form? get form => null;
}

final class FormEditerInitial extends FormEditerState {
  FormEditerInitial(this.form);

  @override
  final Form form;
}
