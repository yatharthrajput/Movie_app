import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {}

class Fetch extends MovieEvent {
  Fetch(this.type);

  final String type;

  @override
  String toString() => "Fetch";
}
