import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:statistika_mobile/features/survey/data/repository/admin_group_repository.dart';
import 'package:statistika_mobile/features/survey/domain/model/admin_group/admin_group.dart';

part 'admin_group_state.dart';

class AdminGroupCubit extends Cubit<AdminGroupState> {
  AdminGroupCubit() : super(AdminGroupEmpty());

  Future<void> init(String? surveyId) async {
    if (surveyId == null) {
      emit(
        AdminGroupError(
          surveyId: surveyId,
          message: 'Что-то пошло не так, попробуйте позже',
        ),
      );
      return;
    }

    emit(AdminGroupLoading());

    final config = await AdminGroupRepository().getAdminGroups(surveyId);

    config.match(
      (e) => emit(
        AdminGroupError(
          surveyId: surveyId,
          message: e.toString(),
        ),
      ),
      (a) => emit(
        AdminGroupInitial(
          surveyId: surveyId,
          adminGroups: a,
        ),
      ),
    );
  }

  Future<void> update() async {
    var state = this.state;
    if (state is AdminGroupInitial && state.surveyId != null) {
      final config =
          await AdminGroupRepository().getAdminGroups(state.surveyId!);

      final surveyId = state.surveyId;
      config.match(
        (e) => emit(
          AdminGroupError(
            surveyId: surveyId,
            message: e.toString(),
          ),
        ),
        (a) => emit(AdminGroupInitial(adminGroups: a)),
      );
    }
    state = this.state;
    if (state is AdminGroupError) {
      await init(state.surveyId);
    }
  }
}
