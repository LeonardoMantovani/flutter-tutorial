import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/utils/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    // create an instance of the WorldTime class
    WorldTime instance = WorldTime(location: 'Rome', flag: 'italy.png', url: 'Europe/Rome');
    // get the Time of the desired WorldTime class and stop until it's done
    await instance.getTime();
    // move to the home screen passing the properties stored in the WorldTime instance
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.grey[900],
          size: 50.0,
        ),
      ),
    );
  }
}
