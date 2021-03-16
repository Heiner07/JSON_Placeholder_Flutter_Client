import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_client/utilities/global_values.dart';
import 'package:json_placeholder_client/view/cubit/show_edit_user_cubit.dart';

class ToDosAlbumsSection extends StatelessWidget {
  const ToDosAlbumsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Theme(
          data: ThemeData(primaryColor: fourthColor),
          child: Scaffold(
            backgroundColor: fourthColor,
            appBar: AppBar(
              leading: Container(),
              leadingWidth: 0,
              title: const TabBar(
                indicatorColor: thirdColor,
                tabs: <Widget>[
                  Tab(
                    icon: Text("ToDos"),
                  ),
                  Tab(
                    icon: Text("Albums"),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      ToDoList(),
                      AlbumsGrid(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlbumsGrid extends StatelessWidget {
  const AlbumsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      builder: (context, state) {
        if (!state.loadingToDosAlbums) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: state.albums.length,
            itemBuilder: (context, index) {
              final album = state.albums[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    album.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
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
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(thirdColor),
          ),
        );
      },
    );
  }
}

class ToDoList extends StatelessWidget {
  const ToDoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowEditUserCubit, ShowEditUserState>(
      builder: (context, state) {
        if (!state.loadingToDosAlbums) {
          return ListView.builder(
            itemCount: state.toDos.length,
            itemBuilder: (context, index) {
              final toDo = state.toDos[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    toDo.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("Completed: ${toDo.completed}",
                      style: TextStyle(fontSize: 16)),
                ),
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
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(thirdColor),
          ),
        );
      },
    );
  }
}
