import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/authorization/domain/model/user_info.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.userInfo,
    required this.createdDate,
    required this.updatedDate,
  });

  final String id;
  final String? name;
  final String? surname;
  final String? username;
  final String email;
  final UserInfo? userInfo;
  final DateTime createdDate;
  final DateTime updatedDate;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
