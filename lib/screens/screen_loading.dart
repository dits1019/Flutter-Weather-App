import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
// json 파싱을 위해
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  //생성되는 순간 딱 한 번만 호출됨
  @override
  void initState() {
    super.initState();
    getLocation();
    fetchData();
  }

  void getLocation() async {
    try {
      //위치의 정확도 정도
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
    } catch (e) {
      print('문제가 발생했습니다.');
    }
  }

  // key값과 value값이 각각 매칭되는 것을 JSON format이라고 함

  void fetchData() async {
    // Uri는 Url의 한 종류라고 할 수 있음
    var url = Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');
    http.Response response = await http.get(url);
    // response.statusCode는 상태를 코드로 가져옴(Ex. 404, 200 ...)
    if (response.statusCode == 200) {
      // response.body는 본문 전체를 가져오기
      String jsonData = response.body;
      var myjson = jsonDecode(jsonData)['weather'][0]['description'];
      var wind = jsonDecode(jsonData)['wind']['speed'];
      var id = jsonDecode(jsonData)['id'];
      print('$myjson, $wind, $id');
    }
  }

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
