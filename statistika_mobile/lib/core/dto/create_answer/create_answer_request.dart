import 'package:json_annotation/json_annotation.dart';

part 'create_answer_request.g.dart';

@JsonSerializable()
class CreateAnswerRequest {
  CreateAnswerRequest({
    required this.questionId,
    required this.answerValueId,
    required this.userId,
  });

  final String questionId;

  final String answerValueId;

  final String? userId;

  factory CreateAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAnswerRequestToJson(this);
}
