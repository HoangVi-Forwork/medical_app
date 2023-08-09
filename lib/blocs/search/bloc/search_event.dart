// File: search_event.dart
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class PerformSearchEvent extends SearchEvent {
  final String tenBenh;

  PerformSearchEvent(this.tenBenh);

  @override
  List<Object> get props => [tenBenh];
}
