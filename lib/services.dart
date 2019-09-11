
import 'package:http/http.dart' as http;
import 'post_model.dart';
import 'dart:async';
import 'package:flutter_fetch_apidata_example/post_model.dart';

String url = 'https://jsonplaceholder.typicode.com/posts';

/*Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);
}*/
  
Future<Post> getPost() async{
  final response = await http.get('$url/1');
  //print(response.body);
  return postFromJson(response.body);
}

Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);

}