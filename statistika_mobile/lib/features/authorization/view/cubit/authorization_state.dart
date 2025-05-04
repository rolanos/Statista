part of 'authorization_cubit.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationEmpty extends AuthorizationState {}

final class AuthorizationLoading extends AuthorizationState {}

final class AuthorizationInited extends AuthorizationState {
  final User user;

  AuthorizationInited({required this.user});
}

final class AuthorizationError extends AuthorizationState {
  final String message;

  AuthorizationError({required this.message});
}
