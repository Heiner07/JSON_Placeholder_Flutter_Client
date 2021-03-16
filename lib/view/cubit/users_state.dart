part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => [users];

  UsersLoaded copyWith({
    List<User>? users,
  }) {
    return UsersLoaded(
      users ?? this.users,
    );
  }
}

class UsersEmpty extends UsersState {}

class UsersFailedLoad extends UsersState {
  const UsersFailedLoad(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
