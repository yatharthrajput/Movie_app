import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class SearchSubmitEvent extends SearchEvent {
  SearchSubmitEvent({this.query}) : super([]);

  final String query;
}
