import 'package:get_it/get_it.dart';
import 'package:json_placeholder_client/data/services/albums_service.dart';
import 'package:json_placeholder_client/data/services/to_do_service.dart';
import 'package:json_placeholder_client/data/services/user_service.dart';
import 'package:http/http.dart' as Http;

GetIt getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<UserService>(() => UserService(Http.Client()));
  getIt.registerLazySingleton<ToDoService>(() => ToDoService(Http.Client()));
  getIt.registerLazySingleton<AlbumService>(() => AlbumService(Http.Client()));
}
