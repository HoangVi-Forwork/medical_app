import 'package:equatable/equatable.dart';

import 'package:medical_app/model/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsList;

  const NewsLoadedState(this.newsList);

  // @override
  // List<Object> get props => [diseasesList];
}

class NewsLoadedWithIDState extends NewsState {
  final List<NewsModel> newsList;

  const NewsLoadedWithIDState(this.newsList);

  // @override
  // List<Object> get props => [diseasesList];
}

class NewsErrorState extends NewsState {
  final String errorMessage;

  const NewsErrorState(this.errorMessage);
}

class NewsLoadedByTypeState extends NewsState {
  final List<NewsModel> newsList;

  const NewsLoadedByTypeState(this.newsList);

  @override
  List<Object> get props => [newsList];
}
