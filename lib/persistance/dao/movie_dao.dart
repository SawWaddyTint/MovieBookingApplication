import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';

class MovieDao {
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }
  MovieDao._internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movies,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  void saveSingleMovie(MovieDetailVO movie) async {
    return getMovieDetailBox().put(movie.id, movie);
  }

  MovieDetailVO getSingleMovies(int movieId) {
    return getMovieDetailBox().get(movieId);
  }

  Box<MovieDetailVO> getMovieDetailBox() {
    return Hive.box<MovieDetailVO>(BOX_NAME_MOVIE_DETAIL_VO);
  }

  /// reactive programming
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  Stream<void> getSingleMovieEventStream() {
    return getMovieDetailBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  Stream<MovieDetailVO> getSingleMovieStream(int movieId) {
    return Stream.value(getSingleMovies(movieId));
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((movie) => movie?.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((movie) => movie?.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }

  MovieDetailVO getMovieDetail(int movieId) {
    if (getSingleMovies(movieId) != null) {
      return getSingleMovies(movieId);
    } else {
      return null;
    }
  }
}
