import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'data.dart'; // courses 데이터가 정의된 파일을 가져옴
import 'jjim.dart';
import 'homebar_navigatePage.dart';
import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodPage(),
    );
  }
}

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  bool isUserPreferenceSelected = true;
  String selectedRegion = '전체';
  String _travelPersonality = '거북이'; // 기본 여행 성향

  @override
  void initState() {
    super.initState();
    _loadTravelPersonality();
  }

  // Hive에서 여행 성향 불러오기
  Future<void> _loadTravelPersonality() async {
    var box = await Hive.openBox('travelPersonalityBox');
    String? savedResult = box.get('travelPersonalityResult');

    setState(() {
      if (savedResult != null) {
        _travelPersonality = _mapPersonality(savedResult);
      }
    });
  }

  // 저장된 성향 값을 category로 변환
  String _mapPersonality(String savedResult) {
    if (savedResult.contains('비둘기')) {
      return '비둘기';
    } else if (savedResult.contains('고양이')) {
      return '고양이';
    } else if (savedResult.contains('강아지')) {
      return '강아지';
    } else if (savedResult.contains('거북이')) {
      return '거북이';
    } else {
      return '거북이';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentFoods =
        courses.where((course) => course['cat'] == 'food').toList();

    // 성향 기반 필터링
    List<Map<String, String>> filteredFoods = isUserPreferenceSelected
        ? currentFoods
            .where((food) => food['category'] == _travelPersonality)
            .toList()
        : currentFoods
            .where((food) => food['category'] != _travelPersonality)
            .toList();

    // 지역 기반 필터링
    filteredFoods = selectedRegion == '전체'
        ? filteredFoods
        : filteredFoods
            .where((food) => food['region'] == selectedRegion)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('식도락'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isUserPreferenceSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUserPreferenceSelected
                          ? Colors.deepPurple.withOpacity(0.7)
                          : Colors.white,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '사용자 성향 기반 추천',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isUserPreferenceSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUserPreferenceSelected
                          ? Colors.white
                          : Colors.deepPurple.withOpacity(0.7),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '새로운 추천 받기',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text('전체'),
                    selected: selectedRegion == '전체',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '전체';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('서울/경기'),
                    selected: selectedRegion == '서울/경기',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '서울/경기';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('강원도'),
                    selected: selectedRegion == '강원도',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '강원도';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('충청도'),
                    selected: selectedRegion == '충청도',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '충청도';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('경상도'),
                    selected: selectedRegion == '경상도',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '경상도';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('전라도'),
                    selected: selectedRegion == '전라도',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '전라도';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                  SizedBox(width: 4),
                  ChoiceChip(
                    label: Text('제주도'),
                    selected: selectedRegion == '제주도',
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = '제주도';
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    showCheckmark: false,
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              children: filteredFoods.map((food) {
                return FoodItem(
                  title: food['title']!,
                  tags: food['tags']!,
                  imageUrl: food['imageUrl']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseDetailScreen(title: food['title']!),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
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
}

class FoodItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String tags;
  final VoidCallback onTap;

  FoodItem({
    required this.imageUrl,
    required this.title,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        tags,
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
      trailing: Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final String title;

  CourseDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text('$title 세부 정보', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
