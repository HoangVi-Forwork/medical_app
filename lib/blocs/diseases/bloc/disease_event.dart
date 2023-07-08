part of 'disease_bloc.dart';

abstract class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object> get props => [];
}

class FetchDiseasesEvent extends DiseaseEvent {}
