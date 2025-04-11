import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/form/data/model/create_form_request.dart';
import 'package:statistika_mobile/features/form/data/repository/form_repository.dart';

part 'create_form_state.dart';

class CreateFormCubit extends Cubit<CreateFormState> {
  CreateFormCubit() : super(CreateFormEmpty());

  Future<void> createForm(
    String name,
    String description,
    String userId,
  ) async {
    final request = CreateFormRequest(
      name: name,
      description: description,
      createdById: userId,
    );
    final result = await FormRepository().createForm(request);
    result.match(
      (e) => emit(CreateFormError(message: e.toString())),
      (f) => emit(CreateFormCreated()),
    );
  }
}
