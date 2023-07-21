import 'package:equatable/equatable.dart';

import '../../model/news_model.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {}

class FetchByNewsTypeEvent extends NewsEvent {
  final int typeId;

  const FetchByNewsTypeEvent(this.typeId);

  @override
  List<Object?> get props => [typeId];
}

class UpdateNewsTypeEvent extends NewsEvent {
  final int typeId;

  const UpdateNewsTypeEvent(this.typeId);

  @override
  List<Object?> get props => [typeId];
}

class UpdateFavouritedNewsListEvent extends NewsEvent {
  final List<NewsModel> favouritedNewsList;

  UpdateFavouritedNewsListEvent(this.favouritedNewsList);
}
