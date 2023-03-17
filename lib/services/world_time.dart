import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDaytime = true;

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      print(now);

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 19  ? true : false;
      time = DateFormat.jm().format(now);      

    } catch (e) {
      print('Error occurred while fetching datax: $e');
    }
  }

}

WorldTime instance = WorldTime(location: 'Singapore', flag: 'singapore.png', url: 'Asia/Singapore');
