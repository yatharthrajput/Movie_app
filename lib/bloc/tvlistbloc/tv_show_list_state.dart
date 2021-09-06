import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/tv/tv_show_model.dart';

@immutable
abstract class TvShowListState extends Equatable {
  TvShowListState([List props = const []]) : super(props);
}

class InitialTvShowListState extends TvShowListState {
  @override
  String toString() => "InitialTvShowListState";
}

class ErrorTvShowListState extends TvShowListState {
  @override
  String toString() => "ErrorTvShowListState";
}

class LoadedTvShowListState extends TvShowListState {
  LoadedTvShowListState({this.tvShowList, this.hasMaxReached, this.page})
      : super([tvShowList, hasMaxReached, page]);

  final List<TvShowModel> tvShowList;
  final bool hasMaxReached;
  final int page;

  LoadedTvShowListState copyWith(
      {List<TvShowModel> tvShowList, bool hasMaxReached, int page}) {
    return LoadedTvShowListState(
        tvShowList: tvShowList ?? this.tvShowList,
        hasMaxReached: hasMaxReached ?? this.hasMaxReached,
        page: page ?? this.page);
  }

  @override
  String toString() => "LoadedTvShowListState";
}


