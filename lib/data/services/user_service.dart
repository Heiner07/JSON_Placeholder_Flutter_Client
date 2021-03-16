import 'dart:convert';

import 'package:json_placeholder_client/models/user.dart';
import 'package:http/http.dart' as Http;
import 'package:json_placeholder_client/utilities/global_values.dart';

const _endpoint = "$baseURL/users";

class UserService {
  final Http.Client http;

  const UserService(this.http);

  Future<List<User>?> getAll() async {
    final url = Uri.parse(_endpoint);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((userMap) => User.fromMap(userMap)).toList();
    }
    return null;
  }

  Future<User?> update(User user) async {
    final url = Uri.parse("$_endpoint/${user.id}");
    final response = await http.put(url, body: user.toMap());
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    }
    return null;
  }

  Future<User?> delete(User user) async {
    final url = Uri.parse("$_endpoint/${user.id}");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return user;
    }
    return null;
  }
}
