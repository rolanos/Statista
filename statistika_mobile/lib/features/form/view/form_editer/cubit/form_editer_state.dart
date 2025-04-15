part of 'form_editer_cubit.dart';

@immutable
sealed class FormEditerState {
  abstract final Form? form;
  abstract final List<Section>? sections;
}

final class FormEditerLoading extends FormEditerState {
  @override
  Form? get form => null;

  @override
  List<Section>? get sections => null;
}

final class FormEditerError extends FormEditerState {
  FormEditerError({required this.message});

  final String message;

  @override
  Form? get form => null;

  @override
  List<Section>? get sections => null;
}

final class FormEditerInitial extends FormEditerState {
  FormEditerInitial({
    required this.form,
    this.sections = const [],
  });

  @override
  final Form form;

  @override
  final List<Section> sections;
}
