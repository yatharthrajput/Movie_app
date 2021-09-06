import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/common/cast.dart';
import 'package:the_movie_app/models/common/images.dart';
import 'package:the_movie_app/models/tvdetails/tv_show_detail_response.dart';

@immutable
abstract class TvShowDetailsState extends Equatable {
  TvShowDetailsState([List props = const []]) : super(props);
}

class InitialTvShowDetailsState extends TvShowDetailsState {
  @override
  String toString() => "InitialTvShowDetailsState";
}

class ErrorTvShowDetailsState extends TvShowDetailsState {
  @override
  String toString() => "ErrorTvShowDetailsState";
}

class LoadedTvShowDetailsState extends TvShowDetailsState {
  LoadedTvShowDetailsState({this.detailResponse, this.images, this.casts})
      : super([detailResponse, images, casts]);

  final TvShowDetailResponse detailResponse;
  final List<Images> images;
  final List<Cast> casts;

  LoadedTvShowDetailsState copyWith(
      {List<TvShowDetailResponse> detailResponse,
      List<Images> images,
      List<Cast> casts}) {
    return LoadedTvShowDetailsState(
        detailResponse: detailResponse ?? this.detailResponse,
        images: images ?? this.images,
        casts: casts ?? this.casts);
  }

  @override
  String toString() => "LoadedTvShowDetailsState";
}
