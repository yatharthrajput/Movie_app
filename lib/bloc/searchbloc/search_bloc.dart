import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie_app/models/search/search_response.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({@required this.repository});

  final Repository repository;

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchEvent> transform(Stream<SearchEvent> events) {
    return (events as Observable<SearchEvent>)
        .debounce(Duration(microseconds: 500));
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchSubmitEvent && !_hasMaxReached(currentState)) {
      final String query = event.query;

      if (query.isEmpty) {
        yield EmptySearchState();
        return;
      }

      try {
        if (currentState is InitialSearchState) {
          final SearchResponse response = await repository.search(query, 1);
          yield LoadedSearchState(
              searchList: response.results,
              hasMaxReached: false,
              page: response.page);
          return;
        }

        if (currentState is LoadedSearchState) {
          final SearchResponse response = await repository.search(
              query, (currentState as LoadedSearchState).page + 1);

          yield response.results.isEmpty
              ? (currentState as LoadedSearchState)
                  .copyWith(hasMaxReached: true)
              : LoadedSearchState(
                  searchList: (currentState as LoadedSearchState).searchList +
                      response.results,
                  hasMaxReached: false,
                  page: response.page);
        }
      } catch (error) {
        yield ErrorSearchState();
      }
    }
  }

  bool _hasMaxReached(SearchState state) =>
      state is LoadedSearchState && state.hasMaxReached;
}
