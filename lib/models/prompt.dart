import 'package:json_annotation/json_annotation.dart';

part 'prompt.g.dart';

@JsonSerializable(explicitToJson: true)
class Prompt {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;

  Prompt({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) => _$PromptFromJson(json);
  Map<String, dynamic> toJson() => _$PromptToJson(this);
}
