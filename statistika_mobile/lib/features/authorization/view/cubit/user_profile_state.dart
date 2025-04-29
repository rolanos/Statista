part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileEmpty extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileError extends UserProfileState {
  UserProfileError({
    required this.message,
  });

  final String message;
}

final class UserProfileInitial extends UserProfileState {
  final User user;

  UserProfileInitial({required this.user});

  //if true then not equals
  bool notCompare(bool? isMan, DateTime? birthday) {
    if (user.userInfo?.isMan != isMan) {
      return true;
    }
    if (birthday != null) {
      if (user.userInfo?.birthday?.compareTo(birthday) != 0) {
        return true;
      }
    }
    return false;
  }
}
