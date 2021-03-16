part of 'show_edit_user_cubit.dart';

enum EditState { NO_ACTION, EDITING, LOADING, SAVED, DELETED, ERROR }

class ShowEditUserState extends Equatable {
  const ShowEditUserState({
    this.name = "",
    this.username = "",
    this.email = "",
    required this.user,
    this.editState = EditState.NO_ACTION,
    this.showDetails = true,
    this.loadingToDosAlbums = true,
    this.toDos = const [],
    this.albums = const [],
  });

  factory ShowEditUserState.withUser(User user) {
    return ShowEditUserState(
      name: user.name,
      username: user.username,
      email: user.email,
      user: user,
    );
  }

  final String name;
  final String username;
  final String email;
  final User user;
  final EditState editState;
  final bool showDetails;
  final bool loadingToDosAlbums;
  final List<ToDo> toDos;
  final List<Album> albums;

  @override
  List<Object?> get props {
    return [
      name,
      username,
      email,
      user,
      editState,
      showDetails,
      loadingToDosAlbums,
      toDos,
      albums,
    ];
  }

  ShowEditUserState copyWith({
    String? name,
    String? username,
    String? email,
    User? user,
    EditState? editState,
    bool? showDetails,
    bool? loadingToDosAlbums,
    List<ToDo>? toDos,
    List<Album>? albums,
  }) {
    return ShowEditUserState(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      user: user ?? this.user,
      editState: editState ?? this.editState,
      showDetails: showDetails ?? this.showDetails,
      loadingToDosAlbums: loadingToDosAlbums ?? this.loadingToDosAlbums,
      toDos: toDos ?? this.toDos,
      albums: albums ?? this.albums,
    );
  }
}
