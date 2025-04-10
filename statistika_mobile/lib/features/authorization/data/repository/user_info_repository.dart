import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:statistika_mobile/core/constants/routes.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user_info.dart';

import '../dto/update_user_info_request.dart';

class UserInfoRepository {
  Future<Either<Exception, UserInfo>> updateUserInfo(
      UpdateUserInfoRequest request) async {
    try {
      final dio = Dio();
      final result = await dio.put(
        ApiRoutes.userInfo,
        data: request.toJson(),
      );

      final data = result.data as Map<String, dynamic>;

      return Either.right(UserInfo.fromJson(data));
    } on DioException catch (e) {
      log(e.toString());
      return Either.left(e);
    } catch (e) {
      log(e.toString());
      return Either.left(Exception("Что-то пошло не так, попробуйте позже"));
    }
  }
}
