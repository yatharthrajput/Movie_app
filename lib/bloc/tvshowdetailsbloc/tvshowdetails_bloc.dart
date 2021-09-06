import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_detail_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_image_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_cast_response.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  TvShowDetailsBloc({this.repository});

  final Repository repository;

  @override
  TvShowDetailsState get initialState => InitialTvShowDetailsState();

  @override
  Stream<TvShowDetailsState> mapEventToState(TvShowDetailsEvent event) async* {
    if (event is FetchTvShowDetails) {
      yield InitialTvShowDetailsState();

      try {
        final TvShowDetailResponse detailsResponse =
            await repository.fetchTvShowDetails(event.id);

        final TvImageResponse tvImagesResponse =
            await repository.fetchTvShowImages(event.id);

        final TvShowCastResponse tvShowCastResponse =
            await repository.fetchTvShowCasts(event.id);

        yield LoadedTvShowDetailsState(
            detailResponse: detailsResponse,
            images: tvImagesResponse.backdrops,
            casts: tvShowCastResponse.cast);
      } catch (_) {
        yield ErrorTvShowDetailsState();
      }
    }
  }
}
