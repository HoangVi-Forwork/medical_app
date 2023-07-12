import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

class FetchWithNewsIDEvent extends NewsEvent {}

class FetchByNewsTypeEvent extends NewsEvent {
  final int typeId;

  const FetchByNewsTypeEvent(this.typeId);

  @override
  List<Object> get props => [typeId];
}
