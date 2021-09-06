import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie_app/models/tv/tv_model_response.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class TvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  TvShowListBloc(this.repository);

  final Repository repository;

  @override
  TvShowListState get initialState => InitialTvShowListState();

  @override
  Stream<TvShowListEvent> transform(Stream<TvShowListEvent> events) {
    return (events as Observable<TvShowListEvent>)
        .debounce(Duration(milliseconds: 200));
  }

  @override
  Stream<TvShowListState> mapEventToState(TvShowListEvent event) async* {
    if (event is TvShowFetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialTvShowListState) {
          final TvShowResponseModel responseModel =
              await repository.fetchTvsByType(event.tvShowType, 1);
          yield LoadedTvShowListState(
              tvShowList: responseModel.results,
              hasMaxReached: false,
              page: responseModel.page);
          return;
        }

        if (currentState is LoadedTvShowListState) {
          final TvShowResponseModel responseModel =
              await repository.fetchTvsByType(event.tvShowType,
                  (currentState as LoadedTvShowListState).page + 1);

          yield responseModel.results.isEmpty
              ? (currentState as LoadedTvShowListState)
                  .copyWith(hasMaxReached: true)
              : LoadedTvShowListState(
                  tvShowList:
                      (currentState as LoadedTvShowListState).tvShowList +
                          responseModel.results,
                  hasMaxReached: false,
                  page: responseModel.page);
        }
      } catch (_) {
        yield ErrorTvShowListState();
      }
    }
  }

  bool _hasReachedMax(TvShowListState state) =>
      state is LoadedTvShowListState && state.hasMaxReached;
}
