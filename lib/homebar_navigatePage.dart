import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:project/test_screen.dart';
import 'seoul.dart';
import 'jejudo.dart';
import 'jyeongsang.dart';
import 'jeonla.dart';
import 'gangwon.dart';
import 'jjim.dart';
import 'test_screen.dart';
import 'FirstScreen.dart';

class RegionCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지역별 카테고리'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListTile(context, '서울/경기', SeoulPage()),
                _buildDivider(),
                _buildListTile(context, '강원도', GangwonPage()),
                _buildDivider(),
                _buildListTile(context, '경상도', JyeongsangPage()),
                _buildDivider(),
                _buildListTile(context, '전라도', JeonlaPage()),
                _buildDivider(),
                _buildListTile(context, '제주도', JejuPage()),
                _buildDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, String title, Widget destinationScreen) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destinationScreen,
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      height: 1.0,
    );
  }
}

// 내주변 지도 페이지
class NearbyMapPage extends StatefulWidget {
  @override
  _NearbyMapPageState createState() => _NearbyMapPageState();
}

class _NearbyMapPageState extends State<NearbyMapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.5665, 126.9780); // 서울의 좌표

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내주변 지도'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

// 마이 페이지 (계정 정보, 찜, 여행성향, 로그아웃 등)
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String travelPersonalityResult = "";
  String loginAccount = "저장된 계정 정보가 없습니다.";

  @override
  void initState() {
    super.initState();
    _loadTravelPersonalityResult(); // 여행 성향 결과 로드
    _loginAccount(); // Hive에서 저장된 계정 정보를 로드
  }

  Future<void> _loginAccount() async {
    var box = await Hive.openBox('loginAccountBox');
    setState(() {
      loginAccount = box.get('loginAccount') ?? "로그인한 계정 정보가 없습니다.";
    });
    await box.close();
  }

  Future<void> _loadTravelPersonalityResult() async {
    var box = await Hive.openBox('travelPersonalityBox');
    setState(() {
      travelPersonalityResult =
          box.get('travelPersonalityResult') ?? "저장된 여행 성향 결과가 없습니다.";
    });
    await box.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이 페이지'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // 계정 정보
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '계정 정보',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '아이디: ${loginAccount}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // 찜
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '찜',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.star, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JjimPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // 성향 테스트 결과 확인
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "현재 여행 성향",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    travelPersonalityResult,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
// 성향 테스트
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '성향 테스트 다시 하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.newspaper, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // 로그아웃
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.black),
                  onPressed: () {
                    // 로그아웃시 FirstScreen으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
