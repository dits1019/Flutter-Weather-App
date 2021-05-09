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
  // var weather;
  // dynamic detail_weather;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    cityName = weatherData['name'];
    var temp2 = weatherData['main']['temp'];
    wind = weatherData['wind']['speed'];
    // weather = weatherData['weather']['main'];
    // detail_weather = weatherData['weather']['description'];

    // round = 소수점 반올림
    temp = temp2.round();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 60),
                  child: Text(cityName,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 300),
                  child: weather_view(FontAwesomeIcons.temperatureHigh,
                      '${temp.toString()}°C', 10),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: weather_view(
                        FontAwesomeIcons.wind, wind.toString(), 20),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                      'https://cdn.pixabay.com/photo/2018/12/10/16/22/city-3867295_1280.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget weather_view(icon, String text, double margin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: FaIcon(
            icon,
            size: 50,
          ),
        ),
        SizedBox(
          width: margin,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
