import 'package:equatable/equatable.dart';
import 'package:the_movie_app/models/movie/movie_model.dart';

abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class MovieUnInitialized extends MovieState {
  @override
  String toString() => "MovieUnInitialized";
}

class MovieError extends MovieState {
  @override
  String toString() => "MovieError";
}

class MovieLoaded extends MovieState {
  MovieLoaded({this.movieList, this.hasReachedMax, this.page})
      : super([movieList, hasReachedMax, page]);

  final List<MovieModel> movieList;
  final bool hasReachedMax;
  final int page;

  MovieLoaded copyWith(
      {List<MovieModel> movieList, bool hasReachedMax, int page}) {
    return MovieLoaded(
        movieList: movieList ?? this.movieList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page);
  }

  @override
  String toString() =>
      'MovieLoaded { movieList: ${movieList.length}, hasReachedMax: $hasReachedMax }';
}
