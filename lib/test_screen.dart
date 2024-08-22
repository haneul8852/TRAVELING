import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'main_screen.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _currentQuestionIndex = 0;
  int _pigeonScore = 0; // 날아다니는 비둘기
  int _catScore = 0; // 차분한 고양이
  int _dogScore = 0; // 사교적인 강아지
  int _turtleScore = 0; // 느긋한 거북이

  final List<Question> _questions = [
    Question(
      questionText: '여행 중에 계획을 세우는 스타일은?',
      options: [
        Option(optionText: 'A. 철저하게 계획하고 예약까지 완료한다.', score: {'turtle': 1}),
        Option(optionText: 'B. 현지에서 상황에 따라 유동적으로 결정한다.', score: {'pigeon': 1}),
      ],
    ),
    Question(
      questionText: '새로운 장소를 방문할 때, 당신은?',
      options: [
        Option(optionText: 'A. 여유롭게 주변을 천천히 탐색한다.', score: {'cat': 1}),
        Option(optionText: 'B. 사람들과 함께 활기찬 장소를 찾아다닌다.', score: {'dog': 1}),
      ],
    ),
    Question(
      questionText: '여행 중 예상치 못한 상황이 발생하면?',
      options: [
        Option(optionText: 'A. 상황을 침착하게 분석하고 대응한다.', score: {'cat': 1}),
        Option(optionText: 'B. 주변 사람들과 함께 문제를 해결한다.', score: {'dog': 1}),
      ],
    ),
    Question(
      questionText: '당신의 이상적인 여행 숙소는?',
      options: [
        Option(optionText: 'A. 조용하고 안락한 곳.', score: {'turtle': 1}),
        Option(optionText: 'B. 활기차고 다양한 사람들과 어울릴 수 있는 곳.', score: {'dog': 1}),
      ],
    ),
    Question(
      questionText: '여행 중 먹고 싶은 음식은?',
      options: [
        Option(optionText: 'A. 새로운 현지 음식을 시도해본다.', score: {'pigeon': 1}),
        Option(optionText: 'B. 익숙하고 편안한 음식을 선택한다.', score: {'turtle': 1}),
      ],
    ),
    Question(
      questionText: '여행 중 휴식 시간에는?',
      options: [
        Option(optionText: 'A. 조용한 곳에서 혼자만의 시간을 즐긴다.', score: {'cat': 1}),
        Option(optionText: 'B. 다른 여행자들과 어울려 새로운 사람들을 만난다.', score: {'dog': 1}),
      ],
    ),
  ];

  void _answerQuestion(Map<String, int> scores) {
    setState(() {
      _pigeonScore += scores['pigeon'] ?? 0;
      _catScore += scores['cat'] ?? 0;
      _dogScore += scores['dog'] ?? 0;
      _turtleScore += scores['turtle'] ?? 0;
      _currentQuestionIndex++;
    });

    if (_currentQuestionIndex >= _questions.length) {
      _showResult();
    }
  }

  void _saveResult(String resultText) async {
    var box = await Hive.openBox('travelPersonalityBox');
    await box.put('travelPersonalityResult', resultText);
    await box.close();
  }

  void _showResult() {
    String resultText;
    String resultEmoji;
    String imagePath;

    if (_pigeonScore >= _catScore &&
        _pigeonScore >= _dogScore &&
        _pigeonScore >= _turtleScore) {
      resultText = '당신은 자유로운 영혼';
      resultEmoji = '날아다니는 비둘기! 🕊️';
      imagePath = 'assets/pigeon.jpg'; // 비둘기 이미지 파일 경로
    } else if (_catScore >= _pigeonScore &&
        _catScore >= _dogScore &&
        _catScore >= _turtleScore) {
      resultText = '당신은 차분하고 독립적인';
      resultEmoji = '도도한 고양이! 🐱';
      imagePath = 'assets/cat.jpg'; // 고양이 이미지 파일 경로
    } else if (_dogScore >= _pigeonScore &&
        _dogScore >= _catScore &&
        _dogScore >= _turtleScore) {
      resultText = '당신은 활발하고 사교적인';
      resultEmoji = '귀여운 강아지! 🐶';
      imagePath = 'assets/dog.jpg'; // 강아지 이미지 파일 경로
    } else {
      resultText = '당신은 느긋하고 여유로운';
      resultEmoji = '느긋한 거북이! 🐢';
      imagePath = 'assets/turtle.jpg'; // 거북이 이미지 파일 경로
    }

    // 결과를 Hive에 저장
    _saveResult(resultText + " " + resultEmoji);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          '여행 성향 결과',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 100), // 이미지 추가
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: resultText + '\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: resultEmoji,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text('확인'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('여행 성향 테스트'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                if (_currentQuestionIndex < _questions.length)
                  Text(
                    _questions[_currentQuestionIndex].questionText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 40),
                if (_currentQuestionIndex < _questions.length)
                  ..._questions[_currentQuestionIndex].options.map(
                        (option) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ElevatedButton(
                            onPressed: () => _answerQuestion(option.score),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[100],
                              foregroundColor: Colors.black,
                            ),
                            child: Text(option.optionText),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<Option> options;

  Question({required this.questionText, required this.options});
}

class Option {
  final String optionText;
  final Map<String, int> score;

  Option({required this.optionText, required this.score});
}
