import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 낮과 밤에 따라 배경 변경
var _now = DateTime.now().hour;
var dayornight = _now >= 18 ? true : false;

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic weatherDataList;

  WeatherScreen({this.parseWeatherData, this.weatherDataList});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var cityName;
  int temp;
  var wind;
  String detail_weather;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.weatherDataList);
  }

  void updateData(dynamic weatherData, dynamic weatherDataList) {
    cityName = weatherData['name'];
    var temp2 = weatherData['main']['temp'];
    wind = weatherData['wind']['speed'];
    detail_weather = weatherData['weather'][0]['description'];

    // round = 소수점 반올림
    temp = temp2.round();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: dayornight ? Colors.lightBlue[900] : Colors.blue[50],
        body: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 60),
                  child: Text(cityName,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: dayornight ? Colors.white : Colors.black)),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 250),
                  child: weather_view(
                      FontAwesomeIcons.temperatureHigh, '${temp.toString()}°C'),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: weather_view(FontAwesomeIcons.wind, wind.toString()),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: AutoSizeText(
                      detail_weather,
                      maxLines: 2,
                      maxFontSize: 35,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: dayornight ? Colors.white : Colors.black),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Image.asset('images/city.png'),
                ),
              ),
              // ListView.builder(
              //     itemBuilder: (BuildContext context, int index) {})
            ],
          ),
        ),
      ),
    );
  }

  Widget weather_view(icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: FaIcon(
            icon,
            size: 50,
            color: dayornight ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: dayornight ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
