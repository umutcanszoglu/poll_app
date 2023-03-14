import 'dart:convert';

class PollBind {
  final String title;
  final String description;
  final List<String> options;
  PollBind({
    required this.title,
    required this.description,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'options': options,
    };
  }

  factory PollBind.fromMap(Map<String, dynamic> map) {
    return PollBind(
      title: map['title'] as String,
      description: map['description'] as String,
      options: List<String>.from(
        (map['options'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PollBind.fromJson(String source) =>
      PollBind.fromMap(json.decode(source) as Map<String, dynamic>);
}
