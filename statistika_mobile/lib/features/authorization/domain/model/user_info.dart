import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  UserInfo({
    required this.id,
    required this.userId,
    required this.isMan,
    required this.name,
    required this.birthday,
  });

  final String id;
  final String userId;
  final String? name;
  final bool? isMan;
  final DateTime? birthday;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
