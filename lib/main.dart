import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
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
      } else if (dailyAverage < 4) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Tracker"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/book.png", height: 200),
          TextField(
            controller: weeklyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Weekly Study Hours',
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(onPressed: calculate, child: const Text("Calculate")),

          const SizedBox(height: 20),
          Text("Weekly Hours: $weeklyHours"),
          Text("Daily Average: ${dailyAverage.toStringAsFixed(2)}"),
          Text("Performance: $performance"),
          Text(message),

          const SizedBox(height: 20),
          Image.asset(imagePath, height: 200, width: 200),
        ],
      ),
    );
  }
}
