import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/celebdetails/celeb_details_response.dart';
import 'package:the_movie_app/models/common/images.dart';
import 'package:the_movie_app/models/movie/movie_model.dart';
import 'package:the_movie_app/models/tv/tv_show_model.dart';

@immutable
abstract class CelebDetailsState extends Equatable {
  CelebDetailsState([List props = const []]) : super(props);
}

class InitialCelebDetailsState extends CelebDetailsState {
  @override
  String toString() => "InitialCelebDetailsState";
}

class ErrorCelebDetailState extends CelebDetailsState {
  @override
  String toString() => "ErrorCelebDetailState";
}

class LoadedCelebDetailState extends CelebDetailsState {
  LoadedCelebDetailState(
      {this.detailsResponse, this.images, this.movies, this.tvShows})
      : super([detailsResponse, images, movies, tvShows]);

  final CelebDetailsResponse detailsResponse;
  final List<Images> images;
  final List<MovieModel> movies;
  final List<TvShowModel> tvShows;

  LoadedCelebDetailState copyWith(
      {CelebDetailsResponse detailsResponse,
      List<Images> images,
      List<MovieModel> movies,
      List<TvShowModel> tvShows}) {
    return LoadedCelebDetailState(
        detailsResponse: detailsResponse ?? this.detailsResponse,
        images: images ?? this.images,
        movies: movies ?? this.movies,
        tvShows: tvShows ?? this.tvShows);
  }

  @override
  String toString() => "LoadedCelebDetailState";
}
