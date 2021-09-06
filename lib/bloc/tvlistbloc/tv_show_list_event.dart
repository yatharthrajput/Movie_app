import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TvShowListEvent extends Equatable {}

class TvShowFetch extends TvShowListEvent {

  TvShowFetch({this.tvShowType});

  final String tvShowType;

  @override
  String toString() => "TvShowFetch";
}
