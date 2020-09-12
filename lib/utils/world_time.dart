import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  // location name for the UI
  String location;
  // url to an asset flag icon
  String flag;
  // location url to the API endpoint
  String url;
  // the time in that location
  String time;
  // if it's daytime or not
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async{
    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create a DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time and isDaytime properties
      print(Intl.systemLocale);
      print(Intl.defaultLocale);
      time = DateFormat.jm().format(now);
      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false;
    }
    catch (e) {
      print(e);
      time = 'getting time failed';
    }
  }

}