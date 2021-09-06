import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {}

class FetchMovieDetails extends MovieDetailsEvent {
  FetchMovieDetails({this.id});

  final String id;
}




