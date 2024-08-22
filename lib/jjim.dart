import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'data.dart';
import 'jeju.dart';

class JjimPage extends StatefulWidget {
  @override
  _JjimPageState createState() => _JjimPageState();
}

class _JjimPageState extends State<JjimPage> {
  List<Map<String, String>> spots = [];

  @override
  void initState() {
    super.initState();
    _loadJjimSpots();
  }

  Future<void> _loadJjimSpots() async {
    var box = Hive.box('jjimBox');
    setState(() {
      spots = courses.where((spot) => box.get(spot['title']) == true).toList();
    });
  }

  void _removeSpot(int index) async {
    var box = Hive.box('jjimBox');
    String title = spots[index]['title']!;
    setState(() {
      spots.removeAt(index);
      courses.firstWhere((course) => course['title'] == title)['jjim'] =
          'false';
      box.put(title, false); // Hive에서 jjim 상태 업데이트
    });
  }

  void _navigateToDetailPage(String title) {
    if (title == '제주도') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JejuScreen()),
      );
    }
    // 다른 페이지로의 이동을 추가할 수 있습니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: spots.length,
              itemBuilder: (context, index) {
                return SpotItem(
                  index: index,
                  title: spots[index]['title']!,
                  tags: spots[index]['tags']!,
                  imageUrl: spots[index]['imageUrl']!,
                  onRemove: _removeSpot,
                  onTap: _navigateToDetailPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpotItem extends StatefulWidget {
  final int index;
  final String title;
  final String tags;
  final String imageUrl;
  final Function(int) onRemove;
  final Function(String) onTap;

  SpotItem({
    required this.index,
    required this.title,
    required this.tags,
    required this.imageUrl,
    required this.onRemove,
    required this.onTap,
  });

  @override
  _SpotItemState createState() => _SpotItemState();
}

class _SpotItemState extends State<SpotItem> {
  bool isFavorited = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    var box = Hive.box('jjimBox');
    setState(() {
      isFavorited = box.get(widget.title) ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          widget.onTap(widget.title);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.tags,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.star : Icons.star_border,
                  color: isFavorited ? Colors.yellow : Colors.grey,
                ),
                onPressed: () async {
                  setState(() {
                    isFavorited = !isFavorited;
                    if (!isFavorited) {
                      widget.onRemove(widget.index);
                    }
                  });
                  var box = Hive.box('jjimBox');
                  box.put(widget.title, isFavorited); // Hive에 jjim 상태 저장
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
