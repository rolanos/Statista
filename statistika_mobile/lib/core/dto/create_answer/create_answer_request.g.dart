// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_answer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAnswerRequest _$CreateAnswerRequestFromJson(Map<String, dynamic> json) =>
    CreateAnswerRequest(
      questionId: json['questionId'] as String,
      answerValueId: json['answerValueId'] as String,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$CreateAnswerRequestToJson(
        CreateAnswerRequest instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'answerValueId': instance.answerValueId,
      'userId': instance.userId,
    };
