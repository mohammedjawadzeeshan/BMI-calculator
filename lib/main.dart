import 'package:flutter/material.dart';

void main() {
  runApp(const BMIApp());
}

class BMIApp extends StatelessWidget {
  const BMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double height = 160; // in cm
  double weight = 60; // in kg

  double calculateBMI() {
    double heightInMeter = height / 100;
    return weight / (heightInMeter * heightInMeter);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "Underweight":
        return Colors.blue.shade300;
      case "Normal":
        return Colors.green.shade400;
      case "Overweight":
        return Colors.orange.shade300;
      case "Obese":
        return Colors.red.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    String category = getBMICategory(bmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Interactive BMI Calculator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Height Slider
            Text(
              "Height: ${height.toStringAsFixed(0)} cm",
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: height,
              min: 80,
              max: 220,
              divisions: 140,
              label: height.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Weight Slider
            Text(
              "Weight: ${weight.toStringAsFixed(0)} kg",
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: weight,
              min: 20,
              max: 200,
              divisions: 180,
              label: weight.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            const SizedBox(height: 30),

            // BMI Result Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: getCategoryColor(category),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    "Your BMI",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Reset Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  height = 160;
                  weight = 60;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Reset", style: TextStyle(fontSize: 18,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
