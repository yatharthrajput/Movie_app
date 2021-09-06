import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CelebListEvent extends Equatable {
  CelebListEvent([List props = const []]) : super(props);
}

class CelebFetch extends CelebListEvent {
  CelebFetch({this.celebType});

  final String celebType;

  @override
  String toString() => "CelebFetch";
}
