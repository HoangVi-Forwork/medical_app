// File: search_state.dart
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:medical_app/model/diseases_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<DiseasesModel> searchResult;

  const SearchLoadedState(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}

class SearchEmptyResultState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
