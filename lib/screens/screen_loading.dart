import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/screen_weather.dart';

// https://openweathermap.org/
const apikey = '718fc9176c8b844ffce641eaafc01955';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // 위도와 경도
  double latitude3;
  double longitude3;

  //생성되는 순간 딱 한 번만 호출됨
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print('$latitude3, $longitude3');

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric&lang=kr');

    Network _network = Network(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&cnt=5&appid=$apikey&units=metric&lang=kr');

    var weatherData = await network.getJsonData();
    var weatherDataList = await _network.getJsonData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(
                  parseWeatherData: weatherData,
                  weatherDataList: weatherDataList,
                )));
  }

  // key값과 value값이 각각 매칭되는 것을 JSON format이라고 함

  // void fetchData() async {

  //     var myjson = parsingData['weather'][0]['description'];
  //     var wind = parsingData['wind']['speed'];
  //     var id = parsingData['id'];
  //     print('$myjson, $wind, $id');
  //   }
  //   // 정상이 아닐 경우
  //   else {
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // 낮과 밤에 따라 배경 변경
    var _now = DateTime.now().hour;
    var dayornight = _now >= 18 ? true : false;

    return Scaffold(
      backgroundColor: dayornight ? Colors.lightBlue[900] : Colors.blue[50],
      body: Center(child: Lottie.asset('images/loading.json')),
    );
  }
}
