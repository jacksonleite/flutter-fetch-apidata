import 'dart:convert';

Post postFromJson(String str){
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data){
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Post> allPostsFromJson(String str){
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"]
  );

  Map<String, dynamic> toJson() =>{
    "userId": userId,
    "id": id,
    "title": title,
    "body": body
  };
}