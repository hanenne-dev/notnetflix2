import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  final List<Movie> _nowPlayingMovieList = [];
  final List<Movie> _upcomingMovieList = [];
  final List<Movie> _animationMovieList = [];

  int _popularMoviePageIndex = 1;
  int _nowPlayingMoviePageIndex = 1;
  int _upcomingMoviePageIndex = 1;
  int _animationMoviePageIndex = 1;
  final String _animationGenre = '16';

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingMovieList => _nowPlayingMovieList;
  List<Movie> get upcomingMovieList => _upcomingMovieList;
  List<Movie> get animationMovieList => _animationMovieList;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await APIService().getPopularMovies(_popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      debugPrint("ERREUR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlayingMovies() async {
    try {
      List<Movie> movies =
          await APIService().getNowPlayingMovies(_nowPlayingMoviePageIndex);
      _nowPlayingMovieList.addAll(movies);
      _nowPlayingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      debugPrint("ERREUR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies =
          await APIService().getUpcomingMovies(_upcomingMoviePageIndex);
      _upcomingMovieList.addAll(movies);
      _upcomingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      debugPrint("ERREUR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await APIService()
          .getAnimationMovies(_animationMoviePageIndex, _animationGenre);
      _animationMovieList.addAll(movies);
      _animationMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      debugPrint("ERREUR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getDetailsMovies({required Movie movie}) async {
    try {
      //on récupère les infos du film
      Movie newMovie = await apiService.getMovie(movie: movie);

      /* await apiService.getDetailsMovies(movie);
      //on récupère les vidéos du film
      newMovie = await apiService.getVideosMovie(movie: newMovie);
      //on récupère le casting du film
      newMovie = await apiService.getCastMovie(movie: newMovie);
      //on récupère les images du film
      newMovie = await apiService.getImagesMovie(movie: newMovie);
 */

      return newMovie;
    } on Response catch (response) {
      debugPrint("ERREUR : ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovies(),
      getNowPlayingMovies(),
      getUpcomingMovies(),
      getAnimationMovies(),
    ]);
  }
}
