import 'package:json_annotation/json_annotation.dart';

part 'faq.g.dart';

@JsonSerializable(explicitToJson: true)
class FAQ {
  @JsonKey(name: 'question')
  final String question;
  @JsonKey(name: 'answer')
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) => _$FAQFromJson(json);
  Map<String, dynamic> toJson() => _$FAQToJson(this);
}
