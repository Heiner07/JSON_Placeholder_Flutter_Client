import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_client/injector.dart' as getIt;
import 'package:json_placeholder_client/utilities/global_values.dart';
import 'package:json_placeholder_client/view/cubit/users_cubit.dart';
import 'package:json_placeholder_client/view/screens/show_edit_user_screen.dart';
import 'package:json_placeholder_client/view/screens/users_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(getIt.getIt())..getAllUsers(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: fourthColor,
        ),
        routes: {
          "ShowEditUser": (context) {
            return ShowEditUserScreen();
          }
        },
        home: UsersScreen(),
      ),
    );
  }
}
