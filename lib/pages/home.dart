import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // the map that will contains all the location's data
  Map data = {};

  @override
  Widget build(BuildContext context) {

    // fill the data map with the context arguments if it's empty,
    // otherwise keep the previously set value (don't need to use the setState
    // function because it's the Widget Tree hasn't already been built)
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    // set background image
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDaytime': result['isDaytime'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    label: Text('Edit Location', style: TextStyle(
                        color: Colors.white,
                    ),),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/flags/${data['flag']}'),
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 64.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
