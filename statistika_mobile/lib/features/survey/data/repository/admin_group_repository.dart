import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/shared_preferences_manager.dart';
import '../../domain/model/admin_group/admin_group.dart';

class AdminGroupRepository {
  Future<Either<Exception, List<AdminGroup>>> getAdminGroups(
    String surveyId,
  ) async {
    try {
      final adminGroup = <AdminGroup>[];
      final dio = Dio();
      final result = await dio.get(
        ApiRoutes.adminGroup,
        queryParameters: {'surveyId': surveyId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final item in Stream.fromIterable(data)) {
        adminGroup.add(AdminGroup.fromJson(item));
      }
      return Either.right(adminGroup);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
