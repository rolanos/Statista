part of 'admin_group_cubit.dart';

@immutable
sealed class AdminGroupState {}

final class AdminGroupLoading extends AdminGroupState {}

final class AdminGroupEmpty extends AdminGroupState {}

final class AdminGroupError extends AdminGroupState {
  AdminGroupError({
    this.surveyId,
    required this.message,
  });

  final String? surveyId;
  final String message;
}

final class AdminGroupInitial extends AdminGroupState {
  AdminGroupInitial({
    this.surveyId,
    required this.adminGroups,
  });

  final String? surveyId;
  final List<AdminGroup> adminGroups;
}
