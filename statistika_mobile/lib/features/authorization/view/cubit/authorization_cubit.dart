import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/authorization/data/repository/authorization_repository.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(AuthorizationEmpty());

  Future<void> login(String email, String password) async {
    if (state is AuthorizationLoading) return;

    emit(AuthorizationLoading());

    if (email.isEmpty) {
      email = 'ivankson@gmail.com';
    }
    if (password.isEmpty) {
      password = '123124';
    }

    final result =
        await AuthorizationRepository().login(email.trim(), password.trim());

    result.match(
      (e) => emit(AuthorizationError(message: e.message)),
      (u) => emit(
        AuthorizationInited(user: u),
      ),
    );
  }
}
