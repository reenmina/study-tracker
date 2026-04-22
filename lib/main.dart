import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 164, 36, 187),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController weeklyController = TextEditingController();

  double weeklyHours = 0;
  double dailyAverage = 0;
  String performance = "";
  String message = "";
  String imagePath = 'assets/images/study.png';

  final audioplayer = AudioPlayer();

  void calculate() {
    double weekly = double.parse(weeklyController.text);

    setState(() {
      weeklyHours = weekly;
      dailyAverage = weeklyHours / 7;

      if (dailyAverage < 2) {
        performance = "Poor";
        message = "You can do better!";
        imagePath = 'assets/images/poor.png';
        audioplayer.play(AssetSource('audio/dissapointed.mp3'));
      } else if (dailyAverage < 5) {
        performance = "Average";
        message = "You are doing great! Keep it up!";
        imagePath = 'assets/images/average.png';
        audioplayer.play(AssetSource('audio/yeay.mp3'));
      } else {
        performance = "Excellent";
        message = "Amazing! Your efforts will not betray you!";
        imagePath = 'assets/images/excellent.png';
        audioplayer.play(AssetSource('audio/applause.mp3'));
      }
    });
  }

  void reset() {
    setState(() {
      weeklyHours = 0;
      dailyAverage = 0;
      performance = "";
      message = "";
      imagePath = 'assets/images/study.png';
    });
    weeklyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 195, 49, 218),
        title: const Text('Study Tracker'),
        titleTextStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/book.png", height: 200),

            TextField(
              controller: weeklyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Weekly Study Hours',
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: calculate,
                  child: const Text("Calculate"),
                ),
                SizedBox(width: 15),
                ElevatedButton(onPressed: reset, child: const Text("Reset")),
              ],
            ),

            const SizedBox(height: 20),
            Text("Weekly Hours: $weeklyHours", style: TextStyle(fontSize: 20)),
            Text(
              "Daily Average: ${dailyAverage.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
            Text("Performance: $performance", style: TextStyle(fontSize: 20)),
            Text(
              message,
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            Image.asset(imagePath, height: 200, width: 200),
          ],
        ),
      ),
    );
  }
}
