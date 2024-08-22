import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firstscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await Hive.initFlutter();

  // 필요한 Hive 박스 열기
  await Hive.openBox('accounts');
  await Hive.openBox('jjimBox'); // jjimBox 추가

  runApp(TravelingApp());
}

class TravelingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.purpleAccent),
      ),
    );
  }
}
