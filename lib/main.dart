import 'package:flutter/material.dart';

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

  void calculate() {
    double weeklyHours = double.parse(weeklyController.text);

    setState(() {
      double dailyAverage = weeklyHours / 7;

      if (dailyAverage < 3) {
        performance = "Poor";
        message = "You need to study more!";
      } else if (dailyAverage < 6) {
        performance = "Average";
        message = "You are doing great! Keep it up!";
      } else {
        performance = "Excellent";
        message = "Amazing! Your efforts will not betray you!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Tracker")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: weeklyController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Weekly Study Hours',
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(onPressed: calculate, child: const Text("Calculate")),

          const SizedBox(height: 20),

          Text("Weekly Hours: $weeklyHours"),
          Text("Daily Average: $dailyAverage"),
          Text("Performance: $performance"),
          Text("Message: $message"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    weeklyController.dispose();
    super.dispose();
  }
}
