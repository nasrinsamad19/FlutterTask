import 'package:sample_flutter_app/album/screen_3/model/comment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Comments> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');
  if (response.statusCode == 200) {
    return Comments.fromJson(jsonDecode(response.body));
  }
  throw Exception('failed to load data');
}

Future<List<Comments>> fetchComments() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1/comments');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((users) => Comments.fromJson(users)).toList();
  }
  throw Exception('Unable to load data');
}

Future<Comments> createComments(String body, String title) async {
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/posts/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'body': body,
    }),
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 201) {
    return Comments.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create ');
  }
}
