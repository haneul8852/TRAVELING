import 'package:flutter/material.dart';
import 'login_screen.dart'; // import the LoginScreen
import 'signup_screen.dart'; // import the SignupScreen
import 'test_screen.dart'; // import the TestScreen

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            // Logo with "TRAVELING" text
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.purple[100] ?? Colors.purple, width: 5),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/traveling.png',
                      width: 100,
                      height: 100,
                      color: Colors.purple[100] ?? Colors.purple,
                    ),
                  ),
                ),
                Text(
                  'TRAVELING',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to LoginScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('로그인'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SignupScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // "나중에 하기" button
            TextButton(
              onPressed: () {
                // Navigate to TestScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestScreen()),
                );
              },
              child: Text(
                '나중에 하기',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
