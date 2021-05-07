import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic parseWeatherData;

  WeatherScreen({this.parseWeatherData});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var cityName;
  int temp;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    cityName = weatherData['name'];
    var temp2 = weatherData['main']['temp'];
    // round = 소수점 반올림
    temp = temp2.round();

    print('$cityName, $temp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('City Name : $cityName', style: TextStyle(fontSize: 30)),
              SizedBox(height: 20),
              Text('Temperature : $temp', style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
