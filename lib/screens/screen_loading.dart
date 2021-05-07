import 'package:flutter/material.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

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
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric');

    var weatherData = await network.getJsonData();
    print(weatherData);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(
                  parseWeatherData: weatherData,
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
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Get my location'),
        ),
      ),
    );
  }
}
