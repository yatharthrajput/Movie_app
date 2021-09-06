import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CelebDetailsEvent extends Equatable {
  CelebDetailsEvent([List props = const []]) : super(props);
}

class FetchCelebDetails extends CelebDetailsEvent {
  FetchCelebDetails({this.id}) : super([id]);
  final String id;
}
