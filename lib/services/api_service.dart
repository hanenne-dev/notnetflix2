import 'package:dio/dio.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // On construit l'URL qu'on va appeler
    String url = api.baseURL + path;

    //On construit les paramètres de la requête
    Map<String, dynamic> query = {
      // paramètres présents dans chaque requêtes
      'api_key': api.apiKey,
      'Language': 'fr-FR',
    };
    // Si params n'est pas null, on a des paramètres en plus on ajoute son contenu à query : num page, num vidéo/image
    if (params != null) {
      query.addAll(params);
    }

    //On fait l'appel
    final response = await dio.get(url, queryParameters: query);

    // On check que la requête s'est bien passée
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies(int numPage) async {
    Response response = await getData('/movie/popular', params: {
      'page': numPage,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = [];
      List<dynamic> results = data['results'];

      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        if (movie.note == null || movie.note! > 7.5) {
          movies.add(movie);
        }
      }

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlayingMovies(int numPage) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': numPage,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = [];
      List<dynamic> results = data['results'];

      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);

        if (movie.note == 0 || movie.note! > 7.5) {
          movies.add(movie);
        }
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies(int numPage) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': numPage,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = [];
      List<dynamic> results = data['results'];

      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
        if (movie.note == 0 || movie.note! > 8) {}
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies(int numPage, String genre) async {
    Response response = await getData('/discover/movie', params: {
      'page': numPage,
      'with_genres': genre,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = [];
      List<dynamic> results = data['results'];

      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getDetailsMovies(Movie movie) async {
    Response response = await getData('/movie/${movie.id}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      var genres = data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();
      Movie repMovie = movie.copyWith(
        genres: genreList,
        releaseDate: data['release_date'],
        note: data['vote_average'],
      );
      return repMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getVideosMovie({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');

    if (response.statusCode == 200) {
      Map data = response.data;
      List<String> videoKeys = data['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(video: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getCastMovie({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/credits');

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Person>? casting = data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return movie.copyWith(casting: casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getImagesMovie({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/images');
    if (response.statusCode == 200) {
      Map data = response.data;
      List<String>? imagesMovie =
          data['backdrops'].map<String>((dynamic imageMovie) {
        return imageMovie['file_path'] as String;
      }).toList();
      return movie.copyWith(imagesMovie: imagesMovie);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}?', params: {
      'append_to_response': 'videos,credits,images',
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      Map dataVideo = data['videos'];
      Map dataCasting = data['credits'];
      Map dataImages = data['images'];
      var genres = data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      List<Person>? casting =
          dataCasting['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      List<String>? imagesMovie =
          dataImages['backdrops'].map<String>((dynamic imageMovie) {
        return imageMovie['file_path'] as String;
      }).toList();
      List<String> videoKeys = dataVideo['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();

      return movie.copyWith(
          casting: casting,
          imagesMovie: imagesMovie,
          genres: genreList,
          releaseDate: data['release_date'],
          note: data['vote_average'],
          video: videoKeys);
    } else {
      throw response;
    }
  }
}
