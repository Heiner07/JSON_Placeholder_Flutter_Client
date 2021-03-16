import 'dart:convert';

import 'package:http/http.dart' as Http;
import 'package:json_placeholder_client/models/album.dart';
import 'package:json_placeholder_client/models/user.dart';
import 'package:json_placeholder_client/utilities/global_values.dart';

const _endpoint = "$baseURL/albums";

class AlbumService {
  final Http.Client http;

  const AlbumService(this.http);

  Future<List<Album>?> getAll(User user) async {
    final url = Uri.parse("$_endpoint?userId=${user.id}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((albumMap) => Album.fromMap(albumMap)).toList();
    }
    return null;
  }
}
