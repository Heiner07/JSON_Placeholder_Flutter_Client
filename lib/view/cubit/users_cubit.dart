import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:json_placeholder_client/data/services/user_service.dart';
import 'package:json_placeholder_client/models/user.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(
    this._userService,
  ) : super(UsersLoading());

  final UserService _userService;

  void getAllUsers() async {
    emit(UsersLoading());
    final users = await _userService.getAll();
    if (users != null) {
      if (users.isEmpty) {
        emit(UsersEmpty());
        return;
      }

      emit(UsersLoaded(users));
    } else {
      emit(UsersFailedLoad("Error loading the users"));
    }
  }

  void updatedUser(User userChanged) {
    if (state is UsersLoaded) {
      final users = (state as UsersLoaded).users.toList();
      final index = users.indexWhere((user) => user.id == userChanged.id);
      if (index > -1) {
        users[index] = userChanged;
        emit(UsersLoaded(users));
      }
    }
  }

  void deleteUser(User userToDelete) {
    if (state is UsersLoaded) {
      final users = (state as UsersLoaded).users.toList();
      final index = users.indexWhere((user) => user.id == userToDelete.id);
      if (index > -1) {
        users.removeAt(index);
        if (users.isEmpty) {
          emit(UsersEmpty());
        } else {
          emit(UsersLoaded(users));
        }
      }
    }
  }
}
