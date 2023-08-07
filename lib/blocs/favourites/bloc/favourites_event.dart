part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class AddToFav extends FavouritesEvent {
  final DiseasesModel diseases;
  const AddToFav(this.diseases);

  @override
  List<Object> get props => [diseases];
}

class RemoveFromFav extends FavouritesEvent {
  final DiseasesModel diseases;
  const RemoveFromFav(this.diseases);

  @override
  List<Object> get props => [diseases];
}