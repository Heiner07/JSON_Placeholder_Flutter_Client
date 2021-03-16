import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_placeholder_client/data/services/albums_service.dart';
import 'package:json_placeholder_client/data/services/to_do_service.dart';
import 'package:json_placeholder_client/data/services/user_service.dart';
import 'package:json_placeholder_client/models/album.dart';
import 'package:json_placeholder_client/models/to_do.dart';
import 'package:json_placeholder_client/models/user.dart';
import 'package:json_placeholder_client/view/cubit/users_cubit.dart';

part 'show_edit_user_state.dart';

class ShowEditUserCubit extends Cubit<ShowEditUserState> {
  ShowEditUserCubit({
    required this.userService,
    required this.toDoService,
    required this.albumService,
    required this.usersCubit,
    required User user,
  }) : super(ShowEditUserState.withUser(user));

  final UserService userService;
  final ToDoService toDoService;
  final AlbumService albumService;
  final UsersCubit usersCubit;

  void getToDosAlbums() async {
    emit(state.copyWith(loadingToDosAlbums: true));
    var toDos = await toDoService.getAll(state.user);
    var albums = await albumService.getAll(state.user);
    if (toDos == null) {
      toDos = [];
    }

    if (albums == null) {
      albums = [];
    }
    emit(state.copyWith(
        toDos: toDos, albums: albums, loadingToDosAlbums: false));
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void onUsernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  bool _userValuesAreCorrect() {
    return state.name.isNotEmpty &&
        !state.name.startsWith(" ") &&
        state.username.isNotEmpty &&
        !state.username.startsWith(" ") &&
        state.email.isNotEmpty &&
        !state.email.startsWith(" ");
  }

  Future<void> submit() async {
    if (_userValuesAreCorrect()) {
      emit(state.copyWith(editState: EditState.LOADING));
      final userUpdated = await userService.update(state.user.copyWith(
        name: state.name.trim(),
        username: state.username.trim(),
        email: state.email.trim(),
      ));

      if (userUpdated != null) {
        usersCubit.updatedUser(userUpdated);
        emit(state.copyWith(editState: EditState.SAVED, user: userUpdated));
      } else {
        emit(state.copyWith(editState: EditState.ERROR));
      }
    }
  }

  Future<void> deleteUser() async {
    emit(state.copyWith(editState: EditState.LOADING));

    final userDeleted = await userService.delete(state.user);

    if (userDeleted != null) {
      usersCubit.deleteUser(userDeleted);
      emit(state.copyWith(editState: EditState.DELETED));
    } else {
      emit(state.copyWith(editState: EditState.ERROR));
    }
  }

  void startEditing() {
    final user = state.user;
    emit(state.copyWith(
      editState: EditState.EDITING,
      name: user.name,
      username: user.username,
      email: user.email,
    ));
  }

  void endEditing() {
    emit(state.copyWith(editState: EditState.NO_ACTION));
  }

  void showHideDetails({bool? value}) {
    emit(state.copyWith(showDetails: value ?? !state.showDetails));
  }
}
