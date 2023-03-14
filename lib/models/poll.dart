import 'dart:convert';

class PollModel {
  final int id;
  final String title;
  final String description;
  final bool voted;
  final List<String> options;
  final List<int>? votes;
  PollModel({
    required this.id,
    required this.title,
    required this.description,
    required this.voted,
    required this.options,
    this.votes,
  });

  Map<String, double> toVoteMap() {
    final result = <String, double>{};
    for (int i = 0; i < options.length; i++) {
      final option = options[i];
      final vote = votes![i];
      result[option] = vote.toDouble();
    }
    return result;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'voted': voted,
      'options': options,
      'votes': votes,
    };
  }

  String toJson() => json.encode(toMap());

  factory PollModel.fromMap(Map<String, dynamic> map) {
    return PollModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      voted: map['voted'] as bool,
      options: List<String>.from((map['options'] as List<dynamic>)),
      votes: map['votes'] != null ? List<int>.from((map['votes'] as List<dynamic>)) : null,
    );
  }

  factory PollModel.fromJson(String source) =>
      PollModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PollModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? voted,
    List<String>? options,
    List<int>? votes,
  }) {
    return PollModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      voted: voted ?? this.voted,
      options: options ?? this.options,
      votes: votes ?? this.votes,
    );
  }
}
