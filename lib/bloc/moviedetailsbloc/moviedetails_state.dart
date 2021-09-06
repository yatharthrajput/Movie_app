import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/common/images.dart';
import 'package:the_movie_app/models/common/cast.dart';
import 'package:the_movie_app/models/moviedetails/movie_details_response.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  MovieDetailsState([List props = const []]) : super(props);
}

class InitialMovieDetailsState extends MovieDetailsState {
  @override
  String toString() => "InitialMovieDetailsState";
}

class ErrorMovieDetailsState extends MovieDetailsState {
  @override
  String toString() => "ErrorMovieDetailsState";
}

class LoadedMovieDetailsState extends MovieDetailsState {
  LoadedMovieDetailsState({this.detailsResponse, this.images, this.casts})
      : super([detailsResponse, images, casts]);

  final MovieDetailsResponse detailsResponse;
  final List<Images> images;
  final List<Cast> casts;

  LoadedMovieDetailsState copyWith(
      {MovieDetailsResponse detailsResponse,
      List<Images> images,
      List<Cast> casts}) {
    return LoadedMovieDetailsState(
        detailsResponse: detailsResponse ?? this.detailsResponse,
        images: images ?? this.images,
        casts: casts ?? this.casts);
  }

  @override
  String toString() => "LoadedMovieDetailsState";
}
