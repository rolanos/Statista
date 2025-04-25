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
}
