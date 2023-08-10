part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel_Copy> users;
  final List<UserInfoModel> userInformation;
  const UserLoaded(this.users, this.userInformation);
  @override
  List<Object> get props => [users, userInformation];
}

class UserLoadedID extends UserState {
  final List<UserModel_Copy> users;
  final List<UserInfoModel> userInformation;

  const UserLoadedID(this.users, this.userInformation);
  @override
  List<Object> get props => [users, userInformation];
}

class UserLoadError extends UserState {
  final String errorMessage;
  const UserLoadError(this.errorMessage);
}
