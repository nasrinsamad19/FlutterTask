import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_flutter_app/album/screen_2/model/album_model.dart';
import 'package:sample_flutter_app/album/screen_2/view_provider/album_view_provider.dart';
import 'package:sample_flutter_app/album/screen_3/model/comment_model.dart';
import 'package:sample_flutter_app/album/screen_3/view_provider/comment_view_provider.dart';

class album extends StatefulWidget {
  @override
  _albumState createState() => _albumState();
}

class _albumState extends State<album> {
  Future<Album> _futureAlbum;
  bool newAlbum = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            AppBar(),
            Flexible(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    newAlbum
                        ? FutureBuilder<Album>(
                            future: _futureAlbum,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ClipRRect(
                                     borderRadius: BorderRadius.circular(30),
                                child: Image.file(File(snapshot.data.url),height: 100,width: MediaQuery.of(context).size.width * .85 ,fit: BoxFit.fill,),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CircularProgressIndicator();
                            })
                        : Container(),
                    ScrollAlbum(),
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
            _takePicture(context);
          },
        ),
      ],
    );
  }

  Widget ScrollAlbum() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child:
      FutureBuilder<List<Album>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Album> data = snapshot.data;
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
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(data[index].url),
                        ),
                      ),
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

  void _takePicture(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        _futureAlbum = createAlbum(picture.path);
        newAlbum = true;
      } else {
        print("No image selected");
      }
    });
  }
}
