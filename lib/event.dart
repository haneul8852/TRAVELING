import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'jjim.dart';
import 'homebar_navigatePage.dart';
import 'main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventPage(),
    );
  }
}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _selectedRegion = '전체';
  List<Map<String, String>> _selectedEvents = [];

  final Map<String, List<Map<String, String>>> _eventsByCategory = {
    '전체': [
      {
        'title': '홍천강 별빛음악 맥주축제',
        'date': '07.31 - 08.04',
        'url': 'https://www.hccf.or.kr/Home/H10000/H10200/html',
        'image': 'assets/event1.jpg'
      },
      {
        'title': '철원 화강 다슬기 축제',
        'date': '08.01 - 08.04',
        'url': 'https://www.gcwcf.or.kr/',
        'image': 'assets/event2.jpg'
      },
      {
        'title': '동강뗏목축제',
        'date': '08.02 - 08.04',
        'url': 'http://www.ywfestival.com/',
        'image': 'assets/event3.jpg'
      },
      {
        'title': '인천펜타포트 락 페스티벌',
        'date': '08.02 - 08.04',
        'url': 'https://www.pentaport.co.kr/',
        'image': 'assets/event4.jpg'
      },
      {
        'title': '서울프린지페스티벌',
        'date': '08.08 - 08.25',
        'url': 'https://www.seoulfringefestival.net:5632/',
        'image': 'assets/event5.jpg'
      },
      {
        'title': '통영한산대첩축제',
        'date': '08.09 - 08.14',
        'url': 'https://tyhansancf.or.kr/',
        'image': 'assets/event6.jpg'
      },
      {
        'title': '국가유산 미디어아트 진주성',
        'date': '08.02 - 08.25',
        'url': 'https://www.mediaartjinju.com/main',
        'image': 'assets/event7.jpg'
      },
      {
        'title': '무주반딧불축제',
        'date': '08.31 - 09.08',
        'url': 'https://www.firefly.or.kr/',
        'image': 'assets/event8.jpg'
      },
      {
        'title': '장수 쿨밸리 페스티벌',
        'date': '08.02 - 08.11',
        'url': 'https://www.jangsufestival.com/coolvalley/',
        'image': 'assets/event9.jpg'
      },
      {
        'title': '충주 문화유산 야행',
        'date': '08.23 - 08.24',
        'url': 'http://www.cjcf.or.kr/',
        'image': 'assets/event10.jpg'
      },
      {
        'title': '괴산고추축제',
        'date': '08.29 - 09.01',
        'url': 'http://spicy-fe.kr/',
        'image': 'assets/event11.jpg'
      },
      {
        'title': '영동포도축제',
        'date': '08.29 - 09.01',
        'url': 'http://www.ydgrape.co.kr/',
        'image': 'assets/event12.jpg'
      },
      {
        'title': '금능원담축제',
        'date': '08.03 - 08.04',
        'url': 'https://www.instagram.com/wondamfestval/',
        'image': 'assets/event13.jpg'
      },
      {
        'title': '휴애리 유럽 수국축제',
        'date': '07.19 - 09.15',
        'url': 'http://hueree.com/index.php',
        'image': 'assets/event14.jpg'
      },
      {
        'title': '둔내고랭지토마토축제',
        'date': '08.09 - 08.11',
        'url': 'https://www.hsg.go.kr/tour/contents.do?key=1375&',
        'image': 'assets/event15.jpg'
      },
      {
        'title': '천리포행 무궁화호',
        'date': '08.08 - 08.18',
        'url': 'https://www.chollipo.org/',
        'image': 'assets/event16.jpg'
      },
      {
        'title': '한강 페스티벌',
        'date': '07.26 - 08.11',
        'url': 'https://festival.seoul.go.kr/hangang',
        'image': 'assets/event17.jpg'
      },
    ],
    '서울/경기': [
      {
        'title': '서울프린지페스티벌',
        'date': '08.08 - 08.25',
        'url': 'https://www.seoulfringefestival.net:5632/',
        'image': 'assets/event5.jpg'
      },
      {
        'title': '인천펜타포트 락 페스티벌',
        'date': '08.02 - 08.04',
        'url': 'https://www.pentaport.co.kr/',
        'image': 'assets/event4.jpg'
      },
      {
        'title': '한강 페스티벌',
        'date': '07.26 - 08.11',
        'url': 'https://festival.seoul.go.kr/hangang',
        'image': 'assets/event17.jpg'
      },
    ],
    '강원도': [
      {
        'title': '홍천강 별빛음악 맥주축제',
        'date': '07.31 - 08.04',
        'url': 'https://www.hccf.or.kr/Home/H10000/H10200/html',
        'image': 'assets/event1.jpg'
      },
      {
        'title': '철원 화강 다슬기 축제',
        'date': '08.01 - 08.04',
        'url': 'https://www.gcwcf.or.kr/',
        'image': 'assets/event2.jpg'
      },
      {
        'title': '동강뗏목축제',
        'date': '08.02 - 08.04',
        'url': 'http://www.ywfestival.com/',
        'image': 'assets/event3.jpg'
      },
      {
        'title': '둔내고랭지토마토축제',
        'date': '08.09 - 08.11',
        'url': 'https://www.hsg.go.kr/tour/contents.do?key=1375&',
        'image': 'assets/event15.jpg'
      },
    ],
    '충청도': [
      {
        'title': '충주 문화유산 야행',
        'date': '08.23 - 08.24',
        'url': 'http://www.cjcf.or.kr/',
        'image': 'assets/event10.jpg'
      },
      {
        'title': '괴산고추축제',
        'date': '08.29 - 09.01',
        'url': 'http://spicy-fe.kr/',
        'image': 'assets/event11.jpg'
      },
      {
        'title': '영동포도축제',
        'date': '08.29 - 09.01',
        'url': 'http://www.ydgrape.co.kr/',
        'image': 'assets/event12.jpg'
      },
      {
        'title': '천리포행 무궁화호',
        'date': '08.08 - 08.18',
        'url': 'https://www.chollipo.org/',
        'image': 'assets/event16.jpg'
      },
    ],
    '경상도': [
      {
        'title': '통영한산대첩축제',
        'date': '08.09 - 08.14',
        'url': 'https://tyhansancf.or.kr/',
        'image': 'assets/event6.jpg'
      },
      {
        'title': '국가유산 미디어아트 진주성',
        'date': '08.02 - 08.25',
        'url': 'https://www.mediaartjinju.com/main',
        'image': 'assets/event7.jpg'
      },
    ],
    '전라도': [
      {
        'title': '무주반딧불축제',
        'date': '08.31 - 09.08',
        'url': 'https://www.firefly.or.kr/',
        'image': 'assets/event8.jpg'
      },
      {
        'title': '장수 쿨밸리 페스티벌',
        'date': '08.02 - 08.11',
        'url': 'https://www.jangsufestival.com/coolvalley/',
        'image': 'assets/event9.jpg'
      },
    ],
    '제주도': [
      {
        'title': '금능원담축제',
        'date': '08.03 - 08.04',
        'url': 'https://www.instagram.com/wondamfestval/',
        'image': 'assets/event13.jpg'
      },
      {
        'title': '휴애리 유럽 수국축제',
        'date': '07.19 - 09.15',
        'url': 'http://hueree.com/index.php',
        'image': 'assets/event14.jpg'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '이벤트',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey),
          _buildRegionSelection(),
          SizedBox(height: 4),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _updateSelectedEvents();
              });
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: _buildEventList(),
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

  void _updateSelectedEvents() {
    final allEvents = _eventsByCategory['전체'] ?? [];
    if (_selectedDay != null) {
      final selectedDateString = _formatDate(_selectedDay!);
      _selectedEvents = allEvents.where((event) {
        final eventDates = event['date']!.split(' - ');
        final startDate = _parseDate(eventDates[0]);
        final endDate = _parseDate(eventDates[1]);
        return selectedDateString != null &&
            selectedDateString.compareTo(eventDates[0]) >= 0 &&
            selectedDateString.compareTo(eventDates[1]) <= 0;
      }).toList();
    }

    if (_selectedRegion != '전체') {
      final regionEvents = _eventsByCategory[_selectedRegion] ?? [];
      _selectedEvents = _selectedEvents.where((event) {
        return regionEvents
            .any((regionEvent) => regionEvent['title'] == event['title']);
      }).toList();
    }
  }

  DateTime _parseDate(String date) {
    final parts = date.split('.');
    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = DateTime.now().year;
    return DateTime(year, month, day);
  }

  String? _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$month.$day';
  }

  Widget _buildRegionSelection() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _eventsByCategory.keys.map((region) {
            return _buildRegionButton(region, _selectedRegion == region);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRegionButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          minimumSize: Size(0, 0),
        ),
        onPressed: () {
          setState(() {
            _selectedRegion = text;
            _updateSelectedEvents();
          });
        },
        child: Text(text, style: TextStyle(fontSize: 13)),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        final event = _selectedEvents[index];
        return ListTile(
          leading: Image.asset(
            event['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(event['title']!),
          subtitle: Text(event['date']!),
          trailing: IconButton(
            icon: Icon(Icons.link, size: 20),
            onPressed: () async {
              final url = Uri.parse(event['url']!);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        );
      },
    );
  }
}
