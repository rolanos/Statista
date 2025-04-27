import 'package:json_annotation/json_annotation.dart';

part 'classifier.g.dart';

@JsonSerializable()
class Classifier {
  Classifier({
    required this.id,
    required this.name,
    required this.parentId,
  });

  final String id;
  final String name;
  final String? parentId;

  factory Classifier.fromJson(Map<String, dynamic> json) =>
      _$ClassifierFromJson(json);

  Map<String, dynamic> toJson() => _$ClassifierToJson(this);
}
