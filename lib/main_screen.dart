import 'package:flutter/material.dart';
import 'course_recommendation_screen.dart';
import 'event.dart';
import 'activity.dart';
import 'hotSpot.dart';
import 'alone.dart';
import 'food.dart';
import 'holiday.dart';
import 'seoul.dart';
import 'jejudo.dart';
import 'jyeongsang.dart';
import 'jeonla.dart';
import 'gangwon.dart';
import 'real_time_info_screen.dart';
import 'real_time_travel_info.dart';
import 'homebar_navigatePage.dart';
import 'jjim.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TRAVELING'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  _search(context);
                },
                decoration: InputDecoration(
                  hintText: '어디로 떠날까요?',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpotPage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('favourite', '인기명소'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityPage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('lifestyle', '액티비티'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HolidayPage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('summer-holidays', '휴양지'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodPage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('feeding', '식도락'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlonePage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('adventure', '나홀로여행'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseRecommendationScreen(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('destination', '코스 추천받기'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RealTimeInfoScreen(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('informative', '실시간 여행 정보'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventPage(),
                        ),
                      );
                    },
                    child: _buildIconMenuItem('calendar', '이벤트'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '인기 여행지',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildPopularDestination('대전', '빵의 도시', 'Daejeon'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JejuPage()),
                      );
                    },
                    child: _buildPopularDestination('제주', '한라봉', 'jeju-do'),
                  ),
                  _buildPopularDestination('양양', '서핑', 'Yang'),
                  _buildPopularDestination('포항', '호미곶', 'pohanghang'),
                  _buildPopularDestination('강릉', '경포해변', 'gang'),
                  _buildPopularDestination('부산', '광안리', 'Busan'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '실시간 여행 정보',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            RealTimeTravelInfo(),
            SizedBox(height: 10),
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

  void _search(BuildContext context) {
    final searchTerm = _searchController.text;
    if (searchTerm.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(searchTerm: searchTerm),
        ),
      );
    }
  }

  Widget _buildIconMenuItem(String iconName, String title) {
    return Column(
      children: [
        Image.asset('assets/$iconName.png', width: 40, height: 40),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildPopularDestination(
      String title, String description, String imageName) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/$imageName.jpg', width: 80, height: 80),
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(description, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final String searchTerm;

  SearchResultPage({required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToDestination(context, searchTerm);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _navigateToDestination(BuildContext context, String searchTerm) {
    switch (searchTerm) {
      case '서울':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SeoulPage()),
        );
        break;
      case '제주':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JejuPage()),
        );
        break;
      case '경기':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SeoulPage()),
        );
        break;
      case '전라도':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JeonlaPage()),
        );
        break;
      case '경상도':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JyeongsangPage()),
        );
        break;
      case '강원도':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GangwonPage()),
        );
        break;
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NoResultsPage(),
          ),
        );
        break;
    }
  }
}

class NoResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          '검색 결과가 없습니다.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
