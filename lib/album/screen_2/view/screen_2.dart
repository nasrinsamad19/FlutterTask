import 'package:flutter/material.dart';

class album extends StatefulWidget {

  @override
  _albumState createState() => _albumState();
}

class _albumState extends State<album> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
             height: 10
            ),
            AppBar()
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
        IconButton(icon: Icon(Icons.add_circle_rounded),iconSize: 30,color:Colors.black87,onPressed: (){},),
      ],
    );
  }
  Widget ScrollAlbum(){
    return SingleChildScrollView(
      child: Column(
        children: [

        ],
      ),
    );
  }
}
