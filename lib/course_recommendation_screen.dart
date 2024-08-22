import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'data.dart';
import 'activity.dart';
import 'hotSpot.dart';
import 'alone.dart';
import 'food.dart';
import 'holiday.dart';
import 'jjim.dart';
import 'homebar_navigatePage.dart';
import 'main_screen.dart';

class CourseRecommendationScreen extends StatefulWidget {
  @override
  _CourseRecommendationScreenState createState() =>
      _CourseRecommendationScreenState();
}

class _CourseRecommendationScreenState
    extends State<CourseRecommendationScreen> {
  String _travelPersonality = '거북이';

  @override
  void initState() {
    super.initState();
    _loadTravelPersonality();
  }

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

  Future<void> _loadTravelPersonality() async {
    var box = await Hive.openBox('travelPersonalityBox');
    String? savedResult = box.get('travelPersonalityResult');

    setState(() {
      if (savedResult != null) {
        _travelPersonality = _mapPersonality(savedResult);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCourses = courses
        .where((course) => course['category'] == _travelPersonality)
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('코스 추천'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Divider(color: Colors.grey, thickness: 1),
          CategoryRow(),
          Expanded(
            child: ListView(
              children: filteredCourses.map((course) {
                return CourseItem(
                  title: course['title']!,
                  tags: course['tags']!.split(','),
                  imagePath: course['imageUrl']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseDetailScreen(title: course['title']!),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          )
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

class CategoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategoryItem(
                imagePath: 'assets/favourite.png',
                label: '인기명소',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpotPage(),
                    ),
                  );
                },
              ),
              CategoryItem(
                imagePath: 'assets/lifestyle.png',
                label: '액티비티',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityPage(),
                    ),
                  );
                },
              ),
              CategoryItem(
                imagePath: 'assets/summer-holidays.png',
                label: '휴양지',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HolidayPage(),
                    ),
                  );
                },
              ),
              CategoryItem(
                imagePath: 'assets/feeding.png',
                label: '식도락',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodPage(),
                    ),
                  );
                },
              ),
              CategoryItem(
                imagePath: 'assets/adventure.png',
                label: '나홀로여행',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlonePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 1),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  CategoryItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12.0),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class CourseItem extends StatefulWidget {
  final String title;
  final List<String> tags;
  final String imagePath;
  final VoidCallback onTap;

  CourseItem({
    required this.title,
    required this.tags,
    required this.imagePath,
    required this.onTap,
  });

  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    var box = Hive.box('jjimBox');
    setState(() {
      isFavorited = box.get(widget.title) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                widget.imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorited ? Icons.star : Icons.star_border,
                            color: isFavorited ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: () async {
                            setState(() {
                              isFavorited = !isFavorited;
                            });

                            var box = Hive.box('jjimBox');
                            box.put(widget.title, isFavorited);

                            if (isFavorited) {
                              courses.firstWhere((course) =>
                                      course['title'] == widget.title)['jjim'] =
                                  'true';
                            } else {
                              courses.firstWhere((course) =>
                                      course['title'] == widget.title)['jjim'] =
                                  'false';
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: widget.tags.map((tag) => Text(tag)).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
