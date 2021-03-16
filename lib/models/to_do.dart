import 'dart:convert';

import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  const ToDo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  final int id;
  final int userId;
  final String title;
  final bool completed;

  @override
  List<Object> get props => [id, userId, title, completed];

  ToDo copyWith({
    int? id,
    int? userId,
    String? title,
    bool? completed,
  }) {
    return ToDo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      completed: map['completed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));
}
