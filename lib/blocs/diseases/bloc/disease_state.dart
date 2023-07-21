part of 'disease_bloc.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object> get props => [];
}

class DiseaseInitial extends DiseaseState {}

class DiseaseInitialState extends DiseaseState {}

class DiseaseLoadingState extends DiseaseState {}

class DiseaseLoadedState extends DiseaseState {
  final List<DiseasesModel> diseasesList;

  const DiseaseLoadedState(this.diseasesList);

  // @override
  // List<Object> get props => [diseasesList];
}

class DiseaseErrorState extends DiseaseState {
  final String errorMessage;

  const DiseaseErrorState(this.errorMessage);
}
