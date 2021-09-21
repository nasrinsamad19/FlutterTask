class Comments {
  final int id;
  final String title;
  final String body;

  Comments({this.id,this.title,this.body});

  factory Comments.fromJson(Map<String, dynamic>json) {
    return Comments(
        id: json['id'],
        title: json['title'],
        body: json['body']
    );
  }
}