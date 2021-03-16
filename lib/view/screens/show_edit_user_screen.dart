import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_client/injector.dart';
import 'package:json_placeholder_client/models/user.dart';
import 'package:json_placeholder_client/utilities/global_values.dart';
import 'package:json_placeholder_client/view/cubit/show_edit_user_cubit.dart';
import 'package:json_placeholder_client/view/cubit/users_cubit.dart';
import 'package:json_placeholder_client/view/widgets/to_dos_albums_section.dart';

class ShowEditUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User;
    return BlocProvider(
      create: (context) => ShowEditUserCubit(
        userService: getIt(),
        toDoService: getIt(),
        albumService: getIt(),
        usersCubit: context.read<UsersCubit>(),
        user: user,
      )..getToDosAlbums(),
      child: Builder(
        builder: (context) {
          return BlocListener<ShowEditUserCubit, ShowEditUserState>(
            listenWhen: (previous, current) =>
                previous.editState != current.editState,
            listener: (context, state) {
              if (state.editState == EditState.DELETED) {
                Navigator.pop(context);
              } else if (state.editState == EditState.SAVED) {
                context.read<ShowEditUserCubit>().endEditing();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text("JSON Placeholder Client"),
              ),
              body: Container(
                child: Column(
                  children: [
                    FormSection(),
                    ToDosAlbumsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      buildWhen: (previous, current) =>
          previous.editState != current.editState ||
          previous.showDetails != current.showDetails,
      builder: (context, state) {
        if (state.editState == EditState.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (state.editState == EditState.EDITING) {
          return EditButtons();
        } else if (state.editState == EditState.NO_ACTION) {
          if (state.showDetails) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  text: "Edit user",
                  onClick: () =>
                      context.read<ShowEditUserCubit>().startEditing(),
                ),
                const SizedBox(
                  width: 12,
                ),
                Button(
                  text: "Hide details",
                  onClick: () => context
                      .read<ShowEditUserCubit>()
                      .showHideDetails(value: false),
                  width: 140,
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: "Show details",
                  onClick: () => context
                      .read<ShowEditUserCubit>()
                      .showHideDetails(value: true),
                  width: 140,
                ),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}

class EditButtons extends StatelessWidget {
  const EditButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Button(
              text: "Save",
              onClick: () => context.read<ShowEditUserCubit>().submit(),
            ),
            const SizedBox(
              width: 12,
            ),
            Button(
                text: "Cancel",
                onClick: () => context.read<ShowEditUserCubit>().endEditing(),
                backgroundColor: thirdColor,
                textColor: Colors.black),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
          onPressed: () => context.read<ShowEditUserCubit>().deleteUser(),
        ),
      ],
    );
  }
}

class FormFields extends StatelessWidget {
  const FormFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      buildWhen: (previous, current) =>
          previous.showDetails != current.showDetails ||
          previous.editState != current.editState,
      builder: (context, state) {
        if (state.showDetails) {
          if (state.editState == EditState.EDITING ||
              state.editState == EditState.LOADING) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NameInput(),
                UsernameInput(),
                EmailInput(),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserText(
                  text: state.user.name,
                  label: "Name",
                ),
                UserText(
                  text: state.user.username,
                  label: "Username",
                ),
                UserText(
                  text: state.user.email,
                  label: "Email",
                ),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}

class FormSection extends StatelessWidget {
  const FormSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormFields(),
          const SizedBox(
            height: 8,
          ),
          ButtonsContainer(),
        ],
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return UserTextField(
          initialValue: state.name,
          hint: "Name",
          onChanged: (value) =>
              context.read<ShowEditUserCubit>().onNameChanged(value),
        );
      },
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return UserTextField(
          initialValue: state.username,
          hint: "username",
          onChanged: (value) =>
              context.read<ShowEditUserCubit>().onUsernameChanged(value),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return UserTextField(
          initialValue: state.email,
          hint: "email",
          inputType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<ShowEditUserCubit>().onEmailChanged(value),
        );
      },
    );
  }
}

class UserTextField extends StatelessWidget {
  const UserTextField({
    Key? key,
    required this.initialValue,
    required this.hint,
    this.inputType,
    this.onChanged,
  }) : super(key: key);

  final String initialValue;
  final String hint;
  final TextInputType? inputType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
      ),
      onChanged: onChanged,
    );
  }
}

class UserText extends StatelessWidget {
  const UserText({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.black54),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onClick,
    this.width,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback onClick;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 120,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        onPressed: onClick,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(
              backgroundColor != null ? backgroundColor : secondaryColor),
        ),
      ),
    );
  }
}
