import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:the_movie_app/models/moviedetails/movie_casts_response.dart';
import 'package:the_movie_app/models/moviedetails/movie_details_response.dart';
import 'package:the_movie_app/models/moviedetails/movie_images_response.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc({this.repository});

  final Repository repository;

  @override
  MovieDetailsState get initialState => InitialMovieDetailsState();

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is FetchMovieDetails) {
      yield InitialMovieDetailsState();

      try {
        final MovieDetailsResponse detailsResponse =
            await repository.fetchMovieDetailById(event.id);

        final MovieImagesResponse movieImagesResponse =
            await repository.fetchingMovieImages(event.id);

        final MovieCastsResponse movieCastsResponse =
            await repository.fetchingMovieCasts(event.id);

        yield LoadedMovieDetailsState(
            detailsResponse: detailsResponse,
            images: movieImagesResponse.backdrops,
            casts: movieCastsResponse.cast);
      } catch (_) {
        yield ErrorMovieDetailsState();
      }
    }
  }
}
