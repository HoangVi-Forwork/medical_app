import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/diseases_model.dart';
import '../../../repositories/diseases_repositories.dart';

part 'disease_event.dart';
part 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  final DiseaseRepository diseaseRepository;
  DiseaseBloc(this.diseaseRepository) : super(DiseaseInitial()) {
    on<FetchDiseasesEvent>((event, emit) async {
      emit(DiseaseLoadingState());

      try {
        final List<DiseasesModel> diseasesList =
            await diseaseRepository.fetchDiseasesList();

        emit(DiseaseLoadedState(diseasesList));
      } catch (e) {
        emit(DiseaseErrorState('Error fetching diseases: $e'));
      }
    });
  }
}
