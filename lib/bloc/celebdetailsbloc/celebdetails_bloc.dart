import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:the_movie_app/models/celebdetails/celeb_details_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_images_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_movies_response.dart';
import 'package:the_movie_app/models/celebdetails/celeb_tv_shows_response.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class CelebDetailsBloc extends Bloc<CelebDetailsEvent, CelebDetailsState> {
  CelebDetailsBloc({this.repository});

  final Repository repository;

  @override
  CelebDetailsState get initialState => InitialCelebDetailsState();

  @override
  Stream<CelebDetailsState> mapEventToState(CelebDetailsEvent event) async* {
    if (event is FetchCelebDetails) {
      yield InitialCelebDetailsState();

      try {
        final CelebDetailsResponse detailsResponse =
            await repository.fetchCelebDetails(event.id);

        final CelebImagesResponse celebImageResponse =
            await repository.fetchCelebImages(event.id);

        final CelebMoviesResponse celebMoviesResponse =
            await repository.fetchCelebMovies(event.id);

        final CelebTvShowsResponse celebTvShowsResponse =
            await repository.fetchCelebTvShows(event.id);

        yield LoadedCelebDetailState(
            detailsResponse: detailsResponse,
            images: celebImageResponse.images,
            movies: celebMoviesResponse.movies,
            tvShows: celebTvShowsResponse.tvShows);
      } catch (_) {
        yield ErrorCelebDetailState();
      }
    }
  }
}
