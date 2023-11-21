import 'package:flutter/widgets.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? note;
  final List<String>? video;
  final List<Person>? casting;
  final List<String>? imagesMovie;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
    this.genres,
    this.note,
    this.releaseDate,
    this.video,
    this.casting,
    this.imagesMovie,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    ValueGetter<String?>? posterPath,
    List<String>? genres,
    double? note,
    String? releaseDate,
    List<String>? video,
    List<Person>? casting,
    List<String>? imagesMovie,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath != null ? posterPath() : this.posterPath,
      genres: genres ?? this.genres,
      note: note ?? this.note,
      releaseDate: releaseDate ?? this.releaseDate,
      video: video ?? this.video,
      casting: casting ?? this.casting,
      imagesMovie: imagesMovie ?? this.imagesMovie,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id']?.toInt() ?? 0,
      name: map['title'] ?? '',
      description: map['overview'] ?? '',
      posterPath: map['poster_path'],
      note: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  String posterURL() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

  String? reformatingGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = '$categories${genres![i]}, ';
      }
    }
    return categories;
  }
}
