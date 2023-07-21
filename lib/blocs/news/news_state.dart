import 'package:equatable/equatable.dart';
import 'package:medical_app/model/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsList;

  const NewsLoadedState(this.newsList);

  @override
  List<Object?> get props => [newsList];
}

class NewsErrorState extends NewsState {
  final String errorMessage;

  const NewsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// class NewsLoadedByTypeState extends NewsState {
//   final List<NewsModel> newsList;
//   final int selectedTypeId;

//   const NewsLoadedByTypeState(this.newsList, {this.selectedTypeId = 0});

//   List<NewsModel> get getNewsList => newsList;

//   @override
//   List<Object?> get props => [newsList];
// }
