import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movie_app/models/celeb/celeb_response_model.dart';
import 'package:the_movie_app/repository/repository.dart';
import './bloc.dart';

class CelebListBloc extends Bloc<CelebListEvent, CelebListState> {
  CelebListBloc(this.repository);

  final Repository repository;

  @override
  CelebListState get initialState => InitialCelebListState();

  @override
  Stream<CelebListEvent> transform(Stream<CelebListEvent> events) {
    return (events as Observable<CelebListEvent>)
        .debounce(Duration(microseconds: 500));
  }

  @override
  Stream<CelebListState> mapEventToState(CelebListEvent event) async* {
    if (event is CelebFetch && !_hasMaxReached(currentState)) {
      try {
        if (currentState is InitialCelebListState) {
          final CelebResponseModel itemModel =
              await repository.fetchCelebrities(event.celebType, 1);

          yield LoadedCelebListEstate(
              celebList: itemModel.results,
              hasMaxReached: false,
              page: itemModel.page);
        }

        if (currentState is LoadedCelebListEstate) {
          final CelebResponseModel itemModel =
              await repository.fetchCelebrities(event.celebType,
                  (currentState as LoadedCelebListEstate).page + 1);
          yield itemModel.results.isEmpty
              ? LoadedCelebListEstate(hasMaxReached: true)
              : LoadedCelebListEstate(
                  celebList: (currentState as LoadedCelebListEstate).celebList +
                      itemModel.results,
                  hasMaxReached: false,
                  page: itemModel.page);
        }
      } catch (ex) {
        print(ex.toString());
        yield ErrorCelebListEstate();
      }
    }
  }

  bool _hasMaxReached(CelebListState state) =>
      state is LoadedCelebListEstate && state.hasMaxReached;
}
