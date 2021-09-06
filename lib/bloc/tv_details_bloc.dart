import 'package:rxdart/rxdart.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_detail_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_image_response.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_cast_response.dart';
import 'package:the_movie_app/repository/cache_response_provider.dart';
import 'package:the_movie_app/repository/movie_api_provider.dart';
import 'package:the_movie_app/repository/repository.dart';

class TvDetailsBloc {
  final Repository _repository = Repository(MoviesApiProvider(CacheProvider()));

  final _tvShowDetailsFetcher = PublishSubject<TvShowDetailResponse>();
  final _tvDetailsImagesFetcher = PublishSubject<TvImageResponse>();
  final _tvShowCastsFetcher = PublishSubject<TvShowCastResponse>();

  Observable<TvShowDetailResponse> get allTvShowDetails =>
      _tvShowDetailsFetcher.stream;

  Observable<TvImageResponse> get allTvShowImages =>
      _tvDetailsImagesFetcher.stream;

  Observable<TvShowCastResponse> get allTvShowCasts =>
      _tvShowCastsFetcher.stream;

  fetchTvShowDetails(String id) async {
    TvShowDetailResponse tvShowDetailsResponse =
        await _repository.fetchTvShowDetails(id);
    _tvShowDetailsFetcher.sink.add(tvShowDetailsResponse);
  }

  fetchTvShowImages(String id) async {
    TvImageResponse tvImageResponse = await _repository.fetchTvShowImages(id);
    _tvDetailsImagesFetcher.sink.add(tvImageResponse);
  }

  fetchTvShowCasts(String id) async {
    TvShowCastResponse tvShowCastResponse =
        await _repository.fetchTvShowCasts(id);
    _tvShowCastsFetcher.sink.add(tvShowCastResponse);
  }

  dispose() {
    _tvShowDetailsFetcher.close();
  }

  disposeCast() {
    _tvShowCastsFetcher.close();
  }

  disposeImages() {
    _tvDetailsImagesFetcher.close();
  }
}

final tvDetailBloc = TvDetailsBloc();
