
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final userWeight = TextEditingController();
  final userHeightFeet = TextEditingController();
  final userHeightInches = TextEditingController();
  String ans = "";
  var bgcolorbmi=Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Container(
        color: bgcolorbmi,
        child: Center(
          child: SizedBox(
            width: 350,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "BMI",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  TextField(
                    controller: userWeight,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter your weight in kgs",
                      prefixIcon: Icon(Icons.line_weight),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: userHeightFeet,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter your height in feet",
                      prefixIcon: Icon(Icons.height),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: userHeightInches,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Enter your height in inches",
                      prefixIcon: Icon(Icons.height),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      calculateBMI();
                    },
                    child: const Text("Calculate"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ans,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI() {   // for calculation the bmi
    final weightText = userWeight.text.trim();
    final feetText = userHeightFeet.text.trim();
    final inchesText = userHeightInches.text.trim();

    if (weightText.isEmpty && feetText.isEmpty && inchesText.isEmpty) {
      setState(() {
        ans = "Please enter all details";
      });
      return;
    }

    final weight = double.tryParse(weightText) ?? 0.0;
    final feet = double.tryParse(feetText) ?? 0.0;
    final inches = double.tryParse(inchesText) ?? 0.0;

    final totalInches = (feet * 12) + inches;
    final totalCm = totalInches * 2.54;
    final totalMeters = totalCm / 100;
    final bmi = weight / (totalMeters * totalMeters);

    var message="";

    if(bmi>25.0){
      message="You are over weight";
      bgcolorbmi=Colors.purple.shade300;
    }
    else if(bmi<18){
      message="You are under weight";
      bgcolorbmi=Colors.pinkAccent;
    }
    else{
      message="You are healthy";
      bgcolorbmi=Colors.yellow.shade300;
    }
    setState(() {
      ans = "$message \n BMI is: ${bmi.toStringAsFixed(2)}"; 
    });
  }
}