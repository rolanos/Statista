import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/features/form/data/model/create_answers_to_form_request.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/shared_preferences_manager.dart';

class AnswerRepository {
  Future<Either<Exception, String>> sendFormAnswers(
    CreateAnswersToFormRequest request,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.post(
        ApiRoutes.answersForForm,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(result.data.toString());
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
