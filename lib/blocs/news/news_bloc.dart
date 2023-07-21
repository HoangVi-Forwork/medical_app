import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';

import 'news_event.dart';
import 'news_state.dart';

// part 'news_event.dart';
// part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewRepositories newRepositories;
  NewsBloc(this.newRepositories) : super(NewsInitialState()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        print('tới đây rồi');
        final List<NewsModel> newsList = await newRepositories.fetchNewsList();
        print('hết rồi');
        emit(NewsLoadedState(newsList));
      } catch (e) {
        emit(NewsErrorState('Error fetching News: $e'));
      }
    });
  }
}
