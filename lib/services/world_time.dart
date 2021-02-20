import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the ui
  String time; // the time in that location
  String flag; // url to the asset flag icon
  String url;  // location url for the api endpoint
  bool isDayTime; // true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      Response response  = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);    
      
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      List<String> minutes = data['utc_offset'].split(':');    
      
      // create a DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours:int.parse(offset), minutes: int.parse(minutes[1])));
      
      time = DateFormat.jm().format(now);  
      isDayTime = now.hour > 6 && now.hour<19  ?  true : false;  
    } catch (e) {
      time = "Oops! Error loading the data!";
    }

  }

}