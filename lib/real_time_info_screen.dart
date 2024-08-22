import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 추가
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps 패키지 추가
import 'event.dart'; // EventPage를 event.dart 파일로 관리한다고 가정
import 'jjim.dart';
import 'homebar_navigatePage.dart';
import 'main_screen.dart';

class RealTimeInfoScreen extends StatefulWidget {
  @override
  _RealTimeInfoScreenState createState() => _RealTimeInfoScreenState();
}

class _RealTimeInfoScreenState extends State<RealTimeInfoScreen> {
  String temperature = "Loading...";
  String weatherDescription = "Loading...";
  String humidity = "Loading...";
  String windSpeed = "Loading...";
  String pm10 = "Loading...";
  String pm2_5 = "Loading...";
  String selectedRegion = "서울";
  String regionTemperature = "Loading...";
  String regionWeatherDescription = "Loading...";
  String regionHumidity = "Loading...";
  String regionWindSpeed = "Loading...";
  bool isTrafficView = false; // 교통상황 화면인지 여부를 나타내는 변수
  bool isNewsView = false; // 뉴스 화면인지 여부를 나타내는 변수

  String newsApiKey =
      "50238975751242ada9d352765526d317"; // NewsAPI 키를 여기에 추가하세요
  List<dynamic> newsArticles = []; // 뉴스를 저장할 리스트

  // 한국어 지역 이름을 영어 이름으로 매핑하는 맵
  Map<String, String> regionNameMapping = {
    '서울': 'Seoul',
    '경기도': 'Gyeonggi-do',
    '강원도': 'Gangwon-do',
    '충청남도': 'Chungcheongnam-do',
    '충청북도': 'Chungcheongbuk-do',
    '경상남도': 'Gyeongsangnam-do',
    '경상북도': 'Gyeongsangbuk-do',
    '전라남도': 'Jeollanam-do',
    '전라북도': 'Jeollabuk-do',
  };

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.5665, 126.9780); // 서울의 좌표

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    fetchAirQualityData();
    fetchRegionWeatherData(selectedRegion);
  }

  Future<void> fetchWeatherData() async {
    String apiKey = "35d9fc28c738690f487d517773d97482";
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=Seoul&units=metric&appid=$apiKey";

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
  }

  Future<void> fetchAirQualityData() async {
    String apiKey = "35d9fc28c738690f487d517773d97482";
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=37.5665&lon=126.9780&appid=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        pm10 = data['list'][0]['components']['pm10'].toString();
        pm2_5 = data['list'][0]['components']['pm2_5'].toString();
      });
    } else {
      setState(() {
        pm10 = "Error";
        pm2_5 = "Error";
      });
    }
  }

  Future<void> fetchRegionWeatherData(String region) async {
    String apiKey = "35d9fc28c738690f487d517773d97482";
    String regionEnglishName =
        regionNameMapping[region] ?? region; // 지역 이름을 영어로 변환
    String encodedRegion = Uri.encodeComponent(regionEnglishName);
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$encodedRegion&units=metric&appid=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        regionTemperature = data['main']['temp'].toString();
        regionWeatherDescription = data['weather'][0]['description'];
        regionHumidity = data['main']['humidity'].toString();
        regionWindSpeed = data['wind']['speed'].toString();
      });
    } else {
      setState(() {
        regionTemperature = "Error";
        regionWeatherDescription = "Could not fetch data";
        regionHumidity = "Error";
        regionWindSpeed = "Error";
      });
    }
  }

  Future<void> fetchNewsData() async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?country=kr&apiKey=$newsApiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        newsArticles = data['articles'];
      });
    } else {
      setState(() {
        newsArticles = [];
      });
    }
  }

  void _showRegionSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('지역 선택'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildRegionOption('서울'),
                _buildRegionOption('경기도'),
                _buildRegionOption('강원도'),
                _buildRegionOption('충청남도'),
                _buildRegionOption('충청북도'),
                _buildRegionOption('경상남도'),
                _buildRegionOption('경상북도'),
                _buildRegionOption('전라남도'),
                _buildRegionOption('전라북도'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRegionOption(String region) {
    return ListTile(
      title: Text(region),
      onTap: () {
        setState(() {
          selectedRegion = region;
          fetchRegionWeatherData(region);
        });
        Navigator.of(context).pop();
      },
    );
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

  // URL 열기 함수
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('실시간 정보'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // 정보 아이콘 클릭 시 동작
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildToggleButton(context, "날씨",
                      isSelected: !isTrafficView && !isNewsView),
                  _buildToggleButton(context, "교통상황",
                      isSelected: isTrafficView),
                  _buildToggleButton(context, "뉴스", isSelected: isNewsView),
                  _buildToggleButton(context, "이벤트", navigateToEventPage: true),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (!isTrafficView && !isNewsView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildWeatherInfo(),
              ),
            if (!isTrafficView && !isNewsView) SizedBox(height: 20),
            if (!isTrafficView && !isNewsView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildRegionSettings(),
              ),
            if (!isTrafficView && !isNewsView) SizedBox(height: 20),
            if (!isTrafficView && !isNewsView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildAirQualityInfo(),
              ),
            if (isNewsView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildNewsList(),
              ),
            if (isTrafficView)
              Align(
                alignment: Alignment.center, // 가운데 정렬 설정
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.utic.go.kr/map/map.do?center=126.99192161017376,37.53517378524762&lev=5&menu=traffic');
                    },
                    child: Text('교통상황 보기'),
                  ),
                ),
              ),
            if (isTrafficView) SizedBox(height: 30), // 버튼과 지도 사이에 30px 간격 추가
            if (isTrafficView)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    trafficEnabled: true, // 교통 상황 활성화
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegionCategoryPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on),
                  Text('지역'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NearbyMapPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite),
                  Text('내주변'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/traveling.png', width: 45, height: 45),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JjimPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  Text('찜'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person),
                  Text('마이'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context, String label,
      {bool isSelected = false, bool navigateToEventPage = false}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (label == "교통상황") {
            isTrafficView = true;
            isNewsView = false; // 교통상황 버튼 클릭 시 상태 변경
          } else if (label == "날씨") {
            isTrafficView = false;
            isNewsView = false; // 날씨 버튼 클릭 시 상태 변경
          } else if (label == "뉴스") {
            isTrafficView = false;
            isNewsView = true; // 뉴스 버튼 클릭 시 상태 변경
            fetchNewsData(); // 뉴스 데이터를 가져옵니다.
          } else if (navigateToEventPage) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventPage()),
            );
          }
        });
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Color.fromARGB(255, 44, 116, 216) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 8),
              Text("서울", style: TextStyle(color: Colors.white)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getWeatherIcon(weatherDescription),
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(weatherDescription,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Text("습도: $humidity%", style: TextStyle(color: Colors.white)),
                  Text("풍속: $windSpeed m/s",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text("날씨", style: TextStyle(color: Colors.white)),
          Text("(서울) 현재 시간", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildAirQualityInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cloud, color: Colors.black87),
              SizedBox(width: 8),
              Text("미세먼지 정보", style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 16),
          Text("PM10: $pm10 µg/m³", style: TextStyle(fontSize: 18)),
          Text("PM2.5: $pm2_5 µg/m³", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildRegionSettings() {
    return GestureDetector(
      onTap: _showRegionSelectionDialog,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(221, 83, 82, 82),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 8),
                Text(selectedRegion, style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  regionTemperature,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                Text(
                  "°C",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _getWeatherIcon(regionWeatherDescription),
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(regionWeatherDescription,
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Text("습도: $regionHumidity%",
                        style: TextStyle(color: Colors.white)),
                    Text("풍속: $regionWindSpeed m/s",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("날씨", style: TextStyle(color: Colors.white)),
            Text("($selectedRegion) 현재 시간",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    if (newsArticles.isEmpty) {
      return Center(
        child: Text(
          '뉴스를 불러오지 못했습니다.',
          style: TextStyle(fontSize: 24, color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: newsArticles.map((article) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              leading: article['urlToImage'] != null
                  ? Image.network(
                      article['urlToImage'],
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Container(width: 100, color: Colors.grey),
              title: Text(article['title']),
              onTap: () {
                _openArticle(article['url']);
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  void _openArticle(String url) {
    if (url != null) {
      _launchURL(url);
    }
  }
}
