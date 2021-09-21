import '../model/album_model.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

Future<List<Album>> fetchData() async{
  final response = await http.get("https://jsonplaceholder.typicode.com/photos");
  if(response.statusCode== 200){
    List jsonResponse= json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((users) => Album.fromJson(users)).toList();
  }
  throw Exception('Fail to load data');
}

// Future<bool> createAlbum(body) async {
//   final http.Response response = await http.post('https://jsonplaceholder.typicode.com/photos', body:body
//     // body: jsonEncode(<String, String>{
//     //   'url': url,
//     // }),
//   );
//   print(response.body);
//   print(response.statusCode);
//   if (response.statusCode==201) {
//     return true;
//   } else {
//     throw Exception('Failed to create ');
//   }
//  }

Future<Album> createAlbum(String url) async {
  final http.Response response = await http.post('https://jsonplaceholder.typicode.com/photos', headers: < String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body: jsonEncode(<String, String>{
      'url':url,
    }),
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode==201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create ');
  }
}