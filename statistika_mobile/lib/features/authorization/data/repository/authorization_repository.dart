import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

class AuthorizationRepository {
  Future<Either<Exception, User>> login(String email, String password) async {
    try {
      final dio = Dio();
      final result = await dio.post(
        ApiRoutes.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      for (var element in result.headers.map.entries) {
        if (element.key.toLowerCase() == 'authorization' &&
            element.value.isNotEmpty) {
          final token = (element.value.first).replaceAll('Bearer ', '');
          await SharedPreferencesManager.setToken(token);
        }
      }
      final data = result.data as Map<String, dynamic>;

      return Either.right(User.fromJson(data));
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }
}
