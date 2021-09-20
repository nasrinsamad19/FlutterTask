import 'package:flutter/material.dart';
import 'package:sample_flutter_app/album/screen_2/view/screen_2.dart';
import 'package:sample_flutter_app/album/screen_3/view/screen_3.dart';

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Text('Welcome to the app',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,)),
            SizedBox(
              height: 5,
            ),
            Text('Press a button to get started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,),
            textAlign: TextAlign.start,),
            SizedBox(
              height: 80,
            ),
            Center(
              child:Container(
                height: 80,
                width: 300,
                child:
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.black,
                  child: Text(
                    'Discover an album',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => album()),
                    );
                  },
                ),

              ) ,
            ),

            SizedBox(
              height: 10,
            ),
            Center(
              child:Container(
                height: 80,
                width: 300,
                child:
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.black,
                  child: Text(
                    'Discover a post',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => post()),
                    );
                  },
                ),

              ) ,
            )
          ],
        ),
      )
    );
  }
}
