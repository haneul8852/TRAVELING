import 'package:flutter/material.dart';
import 'data.dart';
import 'jeju.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JejuPage(),
    );
  }
}

class JejuPage extends StatefulWidget {
  @override
  _JejuPageState createState() => _JejuPageState();
}

class _JejuPageState extends State<JejuPage> {
  String selectedCat = '전체';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentJeju =
        courses.where((jeju) => jeju['region'] == '제주도').toList();

    List<Map<String, String>> filteredJeju = selectedCat == '전체'
        ? currentJeju
        : currentJeju.where((jeju) => jeju['cat'] == selectedCat).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('제주도'),
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text('전체'),
                    selected: selectedCat == '전체',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = '전체';
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
                    label: Text('인기명소'),
                    selected: selectedCat == 'hotspot',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = 'hotspot';
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
                    label: Text('액티비티'),
                    selected: selectedCat == 'activity',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = 'activity';
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
                    label: Text('휴양지'),
                    selected: selectedCat == 'holiday',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = 'holiday';
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
                    label: Text('식도락'),
                    selected: selectedCat == 'food',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = 'food';
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
                    label: Text('나홀로여행'),
                    selected: selectedCat == 'alone',
                    onSelected: (selected) {
                      setState(() {
                        selectedCat = 'alone';
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
              children: filteredJeju.map((jeju) {
                return SpotItem(
                  title: jeju['title']!,
                  tags: jeju['tags']!,
                  imageUrl: jeju['imageUrl']!,
                  onTap: () {
                    if (jeju['title'] == '제주도') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JejuScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailScreen(title: jeju['title']!),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SpotItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String tags;
  final VoidCallback onTap;

  SpotItem({
    required this.imageUrl,
    required this.title,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text(tags),
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
