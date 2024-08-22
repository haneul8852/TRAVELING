import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeju Locations',
      home: JejuScreen(),
    );
  }
}

class JejuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('제주도'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            height: 1,
          ),
          Expanded(
            child: LocationList(),
          ),
        ],
      ),
    );
  }
}

class LocationList extends StatelessWidget {
  final List<Location> locations = [
    Location(
        number: 1,
        title: '제주 국제공항',
        description: '관광명소 · 제주 시내',
        distance: '',
        km: ''),
    Location(
        number: 2,
        title: '귤밭 76번지',
        description: '테마/체험 · 제주 시내',
        distance: '6.2km',
        km: ''),
    Location(
        number: 3,
        title: '이재모 피자 제주점',
        description: '음식점 · 제주 제주시',
        distance: '1.5km',
        km: ''),
    Location(
        number: 4,
        title: '블루원 요트 투어',
        description: '테마/체험 · 제주 시내',
        distance: '7.7km',
        km: ''),
    Location(
        number: 5,
        title: '제주 승마 공원',
        description: '테마/체험 · 제주 제주시',
        distance: '12.3km',
        km: '예약 가능'),
    Location(
        number: 6,
        title: '블리스풀',
        description: '카페 · 제주 제주시',
        distance: '126m',
        km: ''),
    Location(
        number: 7,
        title: '9.81파크',
        description: '테마/체험 · 애월·한림',
        distance: '4.1km',
        km: '예약 필수'),
    Location(
        number: 8,
        title: '브로콜리지',
        description: '음식점 · 애월·한림',
        distance: '125m',
        km: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LocationDetailScreen(location: locations[index]),
                  ),
                );
              },
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: Text(
                        locations[index].number.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    if (locations[index].distance.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          locations[index].distance,
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locations[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            locations[index].description,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          if (locations[index].km.isNotEmpty)
                            Text(
                              locations[index].km,
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1),
          ],
        );
      },
    );
  }
}

class LocationDetailScreen extends StatefulWidget {
  final Location location;

  LocationDetailScreen({required this.location});

  @override
  _LocationDetailScreenState createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.star : Icons.star_border,
              color: isFavorited ? Colors.yellow : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });

              if (isFavorited) {
                _addToFavorites(widget.location);
              } else {
                _removeFromFavorites(widget.location);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.location.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.location.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                if (widget.location.distance.isNotEmpty)
                  Text(
                    'Distance: ${widget.location.distance}',
                    style: TextStyle(fontSize: 16),
                  ),
                if (widget.location.km.isNotEmpty)
                  Text(
                    widget.location.km,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToFavorites(Location location) {
    // 실제로 즐겨찾기 목록에 추가하는 로직을 여기에 구현하세요.
    print('${location.title} added to favorites');
  }

  void _removeFromFavorites(Location location) {
    // 실제로 즐겨찾기 목록에서 제거하는 로직을 여기에 구현하세요.
    print('${location.title} removed from favorites');
  }
}

class Location {
  final int number;
  final String title;
  final String description;
  final String distance;
  final String km;

  Location({
    required this.number,
    required this.title,
    required this.description,
    required this.distance,
    required this.km,
  });
}
