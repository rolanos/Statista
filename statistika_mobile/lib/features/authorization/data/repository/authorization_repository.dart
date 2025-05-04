import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/core/utils/shared_preferences_manager.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user.dart';

import '../../../../core/utils/dio_client.dart';

class AuthorizationRepository {
  Future<Either<Exception, User>> login(String email, String password) async {
    try {
      final dio = DioClient.dio;
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

      final user = User.fromJson(data);

      await SharedPreferencesManager.setUserId(user.id);

      return Either.right(user);
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }

  Future<Either<Exception, User>> register(
    String email,
    String password,
  ) async {
    try {
      final dio = DioClient.dio;
      final result = await dio.post(
        ApiRoutes.register,
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

      final user = User.fromJson(data);

      await SharedPreferencesManager.setUserId(user.id);

      return Either.right(user);
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }
}
