import 'dart:convert';

import 'package:equatable/equatable.dart';

class Album extends Equatable {
  const Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  final int id;
  final int userId;
  final String title;

  @override
  List<Object> get props => [id, userId, title];

  Album copyWith({
    int? id,
    int? userId,
    String? title,
  }) {
    return Album(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));
}
