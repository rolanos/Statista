import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  const Question({
    required this.id,
    required this.title,
    required this.typeId,
    required this.formId,
    required this.sectionId,
    required this.createdDate,
    required this.availableAnswers,
  });

  final String id;
  final String title;
  final String? typeId;
  final String formId;
  final String? sectionId;
  final DateTime createdDate;
  final List<AvailableAnswer> availableAnswers;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        typeId,
        formId,
        sectionId,
        createdDate,
        availableAnswers,
      ];
}
