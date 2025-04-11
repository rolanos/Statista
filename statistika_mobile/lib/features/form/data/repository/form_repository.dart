import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/form/data/model/create_form_request.dart';
import 'package:statistika_mobile/features/form/domain/model/form.dart';

import '../../../../core/utils/shared_preferences_manager.dart';

class FormRepository {
  Future<Either<Exception, List<Form>>> getFormsBySurveyId(
    String surveyId,
  ) async {
    try {
      final list = <Form>[];
      final dio = Dio();
      final result = await dio.get(
        ApiRoutes.forms,
        queryParameters: {'surveyId': surveyId},
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      final data = result.data as List;
      await for (final element in Stream.fromIterable(data)) {
        list.add(Form.fromJson(element));
      }
      return Either.right(list);
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }

  Future<Either<Exception, Form>> createForm(
    CreateFormRequest request,
  ) async {
    try {
      final dio = Dio();
      final result = await dio.post(
        ApiRoutes.forms,
        data: request.toJson(),
        options: Options(
          headers: await SharedPreferencesManager.getTokenAsMap(),
        ),
      );
      return Either.right(Form.fromJson(result.data));
    } on Exception catch (e) {
      log(e.toString());
      return Either.left(e);
    }
  }
}
