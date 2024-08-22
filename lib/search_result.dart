import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final String searchTerm;

  SearchResultPage({required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    // 실제 검색 결과에 따라 결과를 여기에 표시합니다.
    // 예시로 검색어를 출력해보겠습니다.
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: Center(
        child: Text(
          '검색어: $searchTerm',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
