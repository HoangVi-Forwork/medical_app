import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/blocs/news/news_event.dart';

import '../../model/news_model.dart';
import '../../repositories/news_repositories.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewRepositories newRepositories;
  NewsBloc(this.newRepositories) : super(NewsInitialState()) {
    // FETCH DATA
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final List<NewsModel> newsList = await newRepositories.fetchNewsList();
        emit(NewsLoadedState(newsList));
      } catch (e) {
        emit(NewsErrorState('Error fetching News: $e'));
      }
    });

    // FETCH DATA WITH ID
    // on<FetchByNewsTypeEvent>((event, emit) async {
    //   emit(NewsLoadingState());
    //   try {
    //     final List<NewsModel> newsList =
    //         await newRepositories.fetchNewsListByType(event.typeId);
    //     emit(NewsLoadedByTypeState(newsList, selectedTypeId: event.typeId));
    //   } catch (e) {
    //     emit(NewsErrorState('Error fetching type News: $e'));
    //   }
    // });

    //  UPDATE NEWS TYPE
    // on<UpdateNewsTypeEvent>((event, emit) {
    //   emit(NewsLoadedByTypeState(state.newsList, selectedTypeId: event.typeId));
    // });
  }
}
