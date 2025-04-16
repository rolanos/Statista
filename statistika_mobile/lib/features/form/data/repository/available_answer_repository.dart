import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/form/data/model/create_available_answer_request.dart';
import 'package:statistika_mobile/features/form/data/model/update_available_answer_request.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';

import '../../../../core/utils/shared_preferences_manager.dart';

class AvailableAnswerRepository {
  Future<Either<Exception, AvailableAnswer>> createAnswer(
    CreateAvailableAnswerRequest createRequest,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.post(
        ApiRoutes.availableAnswer,
        data: createRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(AvailableAnswer.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, AvailableAnswer>> updateAnswer(
    UpdateAvailableAnswerRequest updateRequest,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.patch(
        ApiRoutes.availableAnswer,
        data: updateRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(AvailableAnswer.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, AvailableAnswer>> deleteAnswer(String id) async {
    try {
      final dio = Dio();
      final result = await dio.delete(
        ApiRoutes.availableAnswer,
        data: {"id": id},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(AvailableAnswer.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
