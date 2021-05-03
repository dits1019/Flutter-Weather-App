import 'package:flutter/material.dart';
import 'package:weather_app/screens/screen_loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primaryColor: Colors.blue),
      home: Loading(),
    );
  }
}

// API = Application Programming Interface
// 응용 프로그램에서 사용할 수 있도록, 운영 체제나 프로그래밍 언어가 제공하는
// 기능을 제어할 수 있게 만든 인터페이스를 뜻한다. -위키피디아-
// 일련의 표준화된 명령이나 기능
// 매개 역할자로써의 API
