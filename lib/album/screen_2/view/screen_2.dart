import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_flutter_app/album/screen_2/model/album_model.dart';
import 'package:sample_flutter_app/album/screen_2/view_provider/album_view_provider.dart';

class album extends StatefulWidget {

  @override
  _albumState createState() => _albumState();
}

class _albumState extends State<album> {
  Future<Album> _futureAlbum;
  bool newAlbum = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
             height: 50
            ),
            AppBar(),
            Flexible(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    newAlbum ?
                    FutureBuilder<Album>(
                        future: _futureAlbum,
                        builder: (context,snapshot){
                          if (snapshot.hasData){
                            return Container(
                              width: 300,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage(snapshot.data.url) ,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError){
                            return Text('${snapshot.error}');
                          }
                          return CircularProgressIndicator();
                        }
                    ):Container(),
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
  Widget AppBar(){
    return  Row(
      children: [
        IconButton(icon: Icon(Icons.arrow_left),iconSize: 50,color: Colors.black87,onPressed: (){
          Navigator.pop(context);
        },),
        Spacer(),
        IconButton(icon: Icon(Icons.add_circle_rounded),iconSize: 30,color:Colors.black87,onPressed: (){
          _takePicture(context);
        },),
      ],
    );
  }

  Widget ScrollAlbum(){
    return  Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: FutureBuilder<List<Album>>(
                future: fetchData(),
                builder: (context,snapshot) {
                  if (snapshot.hasData) {
                    List<Album> data= snapshot.data;
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: data.length,
                        itemBuilder: (context,index) {
                          return Container(
                            width: 50,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(data[index].thumbnailUrl) ,
                              ),
                            ),
                          );

                        });
                  }
                  else if (snapshot.hasError) {

                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            );

  }
  void _takePicture(BuildContext context)async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picture != null){
        _futureAlbum = createAlbum(picture.path);
        newAlbum = true;

        // final body ={
        //   "url":picture.path,
        // };
        //     createAlbum(body).then((success) {
        //       if(success){
        //        setState(() {
        //          newAlbum = File(picture.path);
        //          print(newAlbum);
        //        });
        //
        //     }
        //       else{
        //         Text('unsucceess');
        //       }
        //     });
      }
      else{
        print("No image selected");
      }
    });
  }
  File _image;
  void _openGallery(BuildContext context)async{
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null){
        _image =File('https://via.placeholder.com/150/d32776');
      }
      else{
        print("No image selected");
      }
    });
  }
}
