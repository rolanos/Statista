import 'package:json_annotation/json_annotation.dart';

part 'available_answer.g.dart';

@JsonSerializable()
class AvailableAnswer {
  AvailableAnswer({
    required this.id,
    required this.text,
    required this.imageLink,
    required this.questionId,
  });

  final String id;
  final String? text;
  final String? imageLink;
  final String questionId;

  factory AvailableAnswer.fromJson(Map<String, dynamic> json) =>
      _$AvailableAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableAnswerToJson(this);
}
