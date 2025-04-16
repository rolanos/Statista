import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/form/data/model/create_question_request.dart';
import 'package:statistika_mobile/features/form/data/model/update_question_request.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../../../../core/utils/shared_preferences_manager.dart';

class QuestionRepository {
  Future<Either<Exception, Question>> createQuestion(
    CreateQuestionRequest createRequest,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.post(
        ApiRoutes.questions,
        data: createRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, Question>> updateQuestion(
    UpdateQuestionRequest updateRequest,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.patch(
        ApiRoutes.questions,
        data: updateRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, Question>> deleteQuestion(String id) async {
    try {
      final dio = Dio();
      final result = await dio.delete(
        ApiRoutes.questions,
        data: {'id': id},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
