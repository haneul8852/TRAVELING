import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'real_time_info_screen.dart';

class RealTimeTravelInfo extends StatefulWidget {
  @override
  _RealTimeTravelInfoState createState() => _RealTimeTravelInfoState();
}

class _RealTimeTravelInfoState extends State<RealTimeTravelInfo> {
  String temperature = "Loading...";
  String weatherDescription = "Loading...";
  String humidity = "Loading...";
  String windSpeed = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    String apiKey = "35d9fc28c738690f487d517773d97482"; // OpenWeatherMap API 키
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=Seoul&units=metric&appid=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          temperature = data['main']['temp'].toString();
          weatherDescription = data['weather'][0]['description'];
          humidity = data['main']['humidity'].toString();
          windSpeed = data['wind']['speed'].toString();
        });
      } else {
        setState(() {
          temperature = "Error";
          weatherDescription = "Could not fetch data";
          humidity = "Error";
          windSpeed = "Error";
        });
      }
    } catch (e) {
      setState(() {
        temperature = "Error";
        weatherDescription = "Could not fetch data";
        humidity = "Error";
        windSpeed = "Error";
      });
    }
  }

  IconData _getWeatherIcon(String description) {
    if (description.contains("clear")) {
      return Icons.wb_sunny;
    } else if (description.contains("clouds")) {
      return Icons.wb_cloudy;
    } else if (description.contains("rain")) {
      return Icons.grain;
    } else if (description.contains("snow")) {
      return Icons.ac_unit;
    } else if (description.contains("thunderstorm")) {
      return Icons.flash_on;
    } else {
      return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RealTimeInfoScreen(), // 페이지 이동
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0), // 좌우 마진을 추가하여 너비 조정
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87, // 어두운 배경색
          borderRadius: BorderRadius.circular(10), // 둥근 모서리
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "서울",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  temperature,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                Text(
                  "°C",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "상태: ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Text(
                              weatherDescription,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text("습도: $humidity%",
                          style: TextStyle(color: Colors.white)),
                      Text("풍속: $windSpeed m/s",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("날씨", style: TextStyle(color: Colors.white)),
            Text("(서울) 현재 시간", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
