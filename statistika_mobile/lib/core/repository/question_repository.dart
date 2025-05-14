import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/dto/create_question/create_question_request.dart';
import 'package:statistika_mobile/core/utils/api_exception.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/form/data/model/update_question_request.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

import '../constants/app_constants.dart';
import '../utils/dio_client.dart';
import '../utils/shared_preferences_manager.dart';

class QuestionRepository {
  Future<Either<ApiException, Question>> getGeneralQuestion() async {
    try {
      final dio = DioClient.dio;
      final result = await dio.get(
        ApiRoutes.generalQuestion,
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> createQuestion(
    CreateQuestionRequest createRequest,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.questions,
        data: createRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> updateQuestion(
    UpdateQuestionRequest updateRequest,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.patch(
        ApiRoutes.questions,
        data: updateRequest.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }

  Future<Either<ApiException, Question>> deleteQuestion(String id) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.delete(
        ApiRoutes.questions,
        data: {'id': id},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Question.fromJson(result.data));
    } on DioException catch (e) {
      return Either.left(e.toParsed);
    } on Exception catch (e) {
      return Either.left(e.toParsed);
    } catch (e) {
      return Either.left(ApiException(AppConstants.defaultError));
    }
  }
}
