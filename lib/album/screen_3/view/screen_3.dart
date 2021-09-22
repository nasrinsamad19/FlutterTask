import 'package:flutter/material.dart';
import 'package:sample_flutter_app/album/screen_3/model/comment_model.dart';
import 'package:sample_flutter_app/album/screen_3/view_provider/comment_view_provider.dart';

class post extends StatefulWidget {
  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
  TextEditingController _commentController = TextEditingController();
  Future<Comments> _futureComments;
  String valueText;
  bool newComment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            AppBar(),
            postSection(),
            newComment ? SizedBox(height: 30) : Container(),
            Flexible(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    newComment
                        ? FutureBuilder<Comments>(
                            future: _futureComments,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width * .76 ,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(snapshot.data.body,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(fontSize: 12, color: Colors.black)),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CircularProgressIndicator();
                            })
                        : Container(),
                    CommentSection()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AppBar() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_left),
          iconSize: 50,
          color: Colors.black87,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.add_circle_rounded),
          iconSize: 30,
          color: Colors.black87,
          onPressed: () {
            _displayTextInputDialog(context);
          },
        ),
      ],
    );
  }

  Widget postSection() {
    return FutureBuilder<Comments>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.all(20),
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  snapshot.data.title,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }

  Widget CommentSection() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: FutureBuilder<List<Comments>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comments> data = snapshot.data;
            return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    width: 50,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(data[index].body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Comment'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _commentController,
              decoration: InputDecoration(hintText: "Comment"),
            ),
            actions: <Widget>[
              newComment
                  ? FlatButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text('UPDATE'),
                      onPressed: () {
                        setState(() {
                          _futureComments = createComments(valueText, null);
                          newComment = true;
                          Navigator.pop(context);
                        });
                        fetchComments();
                      },
                    )
                  : FlatButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        setState(() {
                          if (valueText != null) {
                            _futureComments = createComments(valueText, null);
                            newComment = true;
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        });
                        fetchComments();
                      },
                    ),
              FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
