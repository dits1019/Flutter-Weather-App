import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;

  WeatherScreen({this.parseWeatherData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var cityName;
  int temp;
  var wind;
  var weather;
  var detail_weather;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    cityName = weatherData['name'];
    var temp2 = weatherData['main']['temp'];
    wind = weatherData['wind']['speed'];
    weather = weatherData['weather']['main'];
    detail_weather = weatherData['weather']['description'];

    // round = 소수점 반올림
    temp = temp2.round();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(cityName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Container(
                    child: FaIcon(
                  FontAwesomeIcons.temperatureHigh,
                  size: 100,
                )),
                Text(
                  '${temp.toString()}°C',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
