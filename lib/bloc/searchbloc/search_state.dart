import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/search/search.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class InitialSearchState extends SearchState {
  @override
  String toString() => "InitialSearchState";
}

class ErrorSearchState extends SearchState {
  @override
  String toString() => "ErrorSearchState";
}

class EmptySearchState extends SearchState {
  @override
  String toString() => "EmptySearchState";
}

class LoadedSearchState extends SearchState {
  LoadedSearchState({this.searchList, this.hasMaxReached, this.page})
      : super([searchList, hasMaxReached, page]);

  final List<Search> searchList;
  final bool hasMaxReached;
  final int page;

  LoadedSearchState copyWith(
      {List<Search> searchList, bool hasMaxReached, int page}) {
    return LoadedSearchState(
        searchList: searchList ?? this.searchList,
        hasMaxReached: hasMaxReached ?? this.hasMaxReached,
        page: page ?? this.page);
  }

  @override
  String toString() =>
      'SearchLoaded { searchList: ${searchList.length}, hasReachedMax: $hasMaxReached , page : $page}';
}
