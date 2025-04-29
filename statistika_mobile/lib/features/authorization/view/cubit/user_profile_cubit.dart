import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/authorization/data/dto/update_user_info_request.dart';
import 'package:statistika_mobile/features/authorization/data/repository/user_info_repository.dart';
import 'package:statistika_mobile/features/authorization/data/repository/user_repository.dart';
import 'package:statistika_mobile/features/authorization/domain/enum/gender.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileEmpty());

  void init(User user) => emit(UserProfileInitial(user: user));

  Future<void> update() async {
    final state = this.state;

    if (state is UserProfileInitial) {
      final updated = await UserRepository().getUserById(state.user.id);

      updated.match(
        (e) => emit(UserProfileError(message: e.toString())),
        (u) => emit(UserProfileInitial(user: u)),
      );
    }
  }

  Future<void> updateUserProfileInfo(
    Gender? genderValue,
    DateTime? birthday, {
    bool withLoading = false,
  }) async {
    if (state is UserProfileLoading) return;

    final stateSnap = state;
    if (withLoading) {
      emit(UserProfileLoading());
    }
    if (stateSnap is UserProfileInitial && stateSnap.user.userInfo != null) {
      final userInfo = await UserInfoRepository().updateUserInfo(
        UpdateUserInfoRequest(
          id: stateSnap.user.userInfo!.id,
          isMan: genderValue?.isMan(),
          birthday: birthday,
        ),
      );
      userInfo.match(
        (e) {
          emit(UserProfileError(message: e.toString()));
          emit(stateSnap);
        },
        (u) => emit(
          UserProfileInitial(
            user: stateSnap.user.copyWith(userInfo: u),
          ),
        ),
      );
    } else {
      emit(stateSnap);
    }
  }
}
