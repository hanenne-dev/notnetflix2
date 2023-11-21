import 'package:flutter/widgets.dart';

class Person {
  final String name;
  final String characterName;
  final String? imageURL;
  Person({
    required this.name,
    required this.characterName,
    this.imageURL,
  });

  Person copyWith({
    String? name,
    String? characterName,
    ValueGetter<String?>? imageURL,
  }) {
    return Person(
      name: name ?? this.name,
      characterName: characterName ?? this.characterName,
      imageURL: imageURL != null ? imageURL() : this.imageURL,
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'] ?? '',
      characterName: map['character'] ?? '',
      imageURL: map['profile_path'],
    );
  }
}