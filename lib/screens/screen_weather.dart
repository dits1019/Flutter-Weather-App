import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 낮과 밤에 따라 배경 변경
var _now = DateTime.now().hour;
var dayornight = _now >= 18 ? true : false;

// var _nowYear = DateTime.now().year;
// var _nowMonth = DateTime.now().month;
// var _nowDay = DateTime.now().day;

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;
  final dynamic weatherDataList;

  WeatherScreen({this.parseWeatherData, this.weatherDataList});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // 현재 위치한 도시
  var cityName;
  //오늘 날씨
  int temp;
  var wind;
  String detail_weather;

  List<dynamic> weatherList = [];
  List<dynamic> weatherList1 = [];
  List<dynamic> weatherList2 = [];
  List<dynamic> weatherList3 = [];

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.weatherDataList);
    // print(_nowDay);
  }

  void updateData(dynamic weatherData, dynamic weatherDataList) {
    cityName = weatherData['name'];
    var temp2 = weatherData['main']['temp'];
    wind = weatherData['wind']['speed'];
    detail_weather = weatherData['weather'][0]['description'];
    // round = 소수점 반올림
    temp = temp2.round();

    weatherList1 = [
      weatherDataList['list'][0]['main']['temp'].round(),
      weatherDataList['list'][0]['weather'][0]['description'],
      weatherDataList['list'][0]['wind']['speed']
    ];

    weatherList2 = [
      weatherDataList['list'][1]['main']['temp'].round(),
      weatherDataList['list'][1]['weather'][0]['description'],
      weatherDataList['list'][1]['wind']['speed']
    ];

    weatherList3 = [
      weatherDataList['list'][2]['main']['temp'].round(),
      weatherDataList['list'][2]['weather'][0]['description'],
      weatherDataList['list'][2]['wind']['speed']
    ];

    weatherList.add(weatherList1);
    weatherList.add(weatherList2);
    weatherList.add(weatherList3);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle listTextStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

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
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  height: 250,
                  child: ListView.builder(
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          width: 150,
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 4),
                                        child: FaIcon(
                                          FontAwesomeIcons.temperatureHigh,
                                          size: 25,
                                        )),
                                    Text(
                                      '${weatherList[index][0].toString()}°C',
                                      style: listTextStyle,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 4),
                                        child: FaIcon(
                                          FontAwesomeIcons.wind,
                                          size: 25,
                                        )),
                                    Text(
                                      weatherList[index][2].toString(),
                                      style: listTextStyle,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: AutoSizeText(
                                  weatherList[index][1].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  maxFontSize: 30,
                                  minFontSize: 23,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
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
