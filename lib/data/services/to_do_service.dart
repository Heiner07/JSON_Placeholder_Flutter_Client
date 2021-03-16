import 'dart:convert';

import 'package:http/http.dart' as Http;
import 'package:json_placeholder_client/models/to_do.dart';
import 'package:json_placeholder_client/models/user.dart';
import 'package:json_placeholder_client/utilities/global_values.dart';

const _endpoint = "$baseURL/todos";

class ToDoService {
  final Http.Client http;

  const ToDoService(this.http);

  Future<List<ToDo>?> getAll(User user) async {
    final url = Uri.parse("$_endpoint?userId=${user.id}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((toDoMap) => ToDo.fromMap(toDoMap)).toList();
    }
    return null;
  }
}
