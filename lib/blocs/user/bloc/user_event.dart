// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserFetch extends UserEvent {
  final String email;

  UserFetch(this.email);

  @override
  List<Object> get props => [email];
}

class UserFetchId extends UserEvent {
  final int userID;
  UserFetchId(this.userID);
  @override
  List<Object> get props => [userID];
}

class UserUpdate extends UserEvent {
  final UserModel_Copy user;
  final UserInfoModel userInfo;

  UserUpdate(this.user, this.userInfo);

  @override
  List<Object> get props => [user, userInfo];
}
