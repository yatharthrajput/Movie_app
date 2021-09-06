import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:the_movie_app/models/celeb/celeb_model.dart';

@immutable
abstract class CelebListState extends Equatable {
  CelebListState([List props = const []]) : super(props);
}

class InitialCelebListState extends CelebListState {
  @override
  String toString() => "InitialCelebListState";
}

class ErrorCelebListEstate extends CelebListState {
  @override
  String toString() => "ErrorCelebListEstate";
}

class LoadedCelebListEstate extends CelebListState {
  LoadedCelebListEstate({this.celebList, this.hasMaxReached, this.page})
      : super([celebList, hasMaxReached, page]);

  final List<CelebModel> celebList;
  final bool hasMaxReached;
  final int page;

  LoadedCelebListEstate copyWith(
      List<CelebModel> celebList, bool hasMaxReached, int page) {
    return LoadedCelebListEstate(
        celebList: celebList ?? this.celebList,
        hasMaxReached: hasMaxReached ?? this.hasMaxReached,
        page: page ?? this.hasMaxReached);
  }

  @override
  String toString() => "LoadedCelebListEstate";
}
