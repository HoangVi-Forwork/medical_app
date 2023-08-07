import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_app/model/user_model_copy.dart';
import 'package:medical_app/repositories/user_repositories.dart';

import '../../../model/user_info_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UserFetch>((event, emit) async {
      emit(UserLoading());
      try {
        final List<UserModel_Copy> user =
            await userRepository.fetchUsers(event.email);
        final List<UserInfoModel> userInformation =
            await userRepository.fetchUserInfo(event.email);
        emit(UserLoaded(user as dynamic, userInformation as dynamic));
      } catch (e) {
        emit(UserLoadError('Error fetching userRepository: $e'));
        print("Lôi nè $e");
      }
    });

    on<UserFetchId>((event, emit) async {
      emit(UserLoading());
      try {
        final List<UserModel_Copy> user =
            await userRepository.fetchUsersID(event.userID.toString());
        final List<UserInfoModel> userInformation =
            await userRepository.fetchUserInfo(event.userID.toString());
        emit(UserLoadedID(user as dynamic, userInformation as dynamic));
      } catch (e) {
        emit(UserLoadError('Error fetching userRepository: $e'));
        print("Lôi nè $e");
      }
    });
  }
}
