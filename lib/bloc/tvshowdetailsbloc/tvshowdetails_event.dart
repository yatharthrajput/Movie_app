import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TvShowDetailsEvent extends Equatable {}

class FetchTvShowDetails extends TvShowDetailsEvent {
  FetchTvShowDetails({this.id});

  final String id;
}
