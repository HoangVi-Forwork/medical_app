// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/diseases_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesState([])) {
    on<FavouritesEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      FavouritesEvent event, Emitter<FavouritesState> emit) async {
    if (event is AddToFav) {
      final updatFav = List<DiseasesModel>.from(state.diseasesItems)
        ..add(event.diseases);
      emit(FavouritesState(
        updatFav,
      ));
    } else if (event is RemoveFromFav) {
      final updatFav = List<DiseasesModel>.from(state.diseasesItems)
        ..remove(event.diseases);
      emit(FavouritesState(
        updatFav,
      ));
    }
  }
}
