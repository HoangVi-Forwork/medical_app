part of 'favourites_bloc.dart';

// abstract class FavouritesState extends Equatable {
//   const FavouritesState();

//   @override
//   List<Object> get props => [];
// }

// class FavouritesInitial extends FavouritesState {}

class FavouritesState {
  final List<DiseasesModel> diseasesItems;
  FavouritesState(this.diseasesItems);
}
