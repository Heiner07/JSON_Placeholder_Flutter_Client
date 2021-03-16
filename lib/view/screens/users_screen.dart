import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_client/models/user.dart';
import 'package:json_placeholder_client/utilities/global_values.dart';
import 'package:json_placeholder_client/view/cubit/users_cubit.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fourthColor,
      appBar: AppBar(
        title: Text("JSON Placeholder Client"),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(thirdColor),
              ),
            );
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserListItem(
                  user: user,
                  onClick: () {
                    Navigator.pushNamed(
                      context,
                      "ShowEditUser",
                      arguments: user,
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: Text(
              "Error loading the users",
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({
    Key? key,
    required this.user,
    this.onClick,
  }) : super(key: key);

  final User user;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: const BorderRadius.all(
            const Radius.circular(10),
          ),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              offset: const Offset(2, 2),
              blurRadius: 2.0,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              user.username,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
