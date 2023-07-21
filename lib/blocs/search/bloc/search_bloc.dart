// File: search_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_app/model/diseases_model.dart';
import 'package:medical_app/repositories/diseases_repositories.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DiseaseRepository diseaseRepository;

  SearchBloc(this.diseaseRepository) : super(SearchInitial()) {
    on<PerformSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final List<DiseasesModel> searchResult =
            await diseaseRepository.searchDiseases(event.tenBenh);
        // print("Cái này nằm ở Bloc: " + event.tenBenh);
        if (searchResult.isEmpty) {
          emit(SearchEmptyResultState());
        } else {
          emit(SearchLoadedState(searchResult as dynamic));
        }
      } catch (e) {
        print(e);
        emit(SearchErrorState('Error search: $e'));
      }
    });
  }

  // @override
  // Stream<SearchState> mapEventToState(SearchEvent event) async* {
  //   if (event is PerformSearchEvent) {
  //     yield SearchLoadingState();
  //     print("tmf kiem");
  //     try {
  //       final List<DiseasesModel> searchResult =
  //           await diseaseRepository.searchDiseases(event.query);

  //       yield SearchLoadedState(searchResult);
  //     } catch (e) {
  //       yield SearchErrorState('Error searching diseases: $e');
  //     }
  //   }
  // }

}
