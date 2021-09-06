import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_fetch.dart';
import 'package:the_movie_app/bloc/movielistbloc/movie_state.dart';
import 'package:the_movie_app/models/movie/movie_response_model.dart';
import 'package:the_movie_app/repository/repository.dart';

class MovieListBloc extends Bloc<MovieEvent, MovieState> {
  MovieListBloc(this.repository);

  final Repository repository;

  @override
  MovieState get initialState => MovieUnInitialized();

  @override
  Stream<MovieEvent> transform(Stream<MovieEvent> events) {
    return (events as Observable<MovieEvent>)
        .debounce(Duration(milliseconds: 200));
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieUnInitialized) {
          final MovieResponseModel itemModel =
              await repository.fetchMoviesByType(event.type, 1);
          yield MovieLoaded(
              movieList: itemModel.results,
              hasReachedMax: false,
              page: itemModel.page);
          return;
        }

        if (currentState is MovieLoaded) {
          final MovieResponseModel itemModel =
              await repository.fetchMoviesByType(
                  event.type, (currentState as MovieLoaded).page + 1);
          yield itemModel.results.isEmpty
              ? (currentState as MovieLoaded).copyWith(hasReachedMax: true)
              : MovieLoaded(
                  movieList: (currentState as MovieLoaded).movieList +
                      itemModel.results,
                  hasReachedMax: false,
                  page: itemModel.page);
        }
      } catch (_) {
        yield MovieError();
      }
    }
  }

  bool _hasReachedMax(MovieState state) =>
      state is MovieLoaded && state.hasReachedMax;
}
