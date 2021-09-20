import 'package:flutter/material.dart';

class post extends StatefulWidget {

  @override
  _postState createState() => _postState();
}

class _postState extends State<post> {
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
}
