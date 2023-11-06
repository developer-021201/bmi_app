import 'dart:math';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();

}

  class HomePageState extends State<HomePage> {
  var wtController = TextEditingController();
  var htFeetController = TextEditingController();
  var htInchController = TextEditingController();
  var bmiScore = 0.0;
  var bmiType = "";
  var bgColor = Colors.white;
  var imgPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('BMI'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text('Measure your BMI',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 21,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: wtController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.line_weight),
                      label: Text('Weight'),
                      hintText: "Enter your Weight(in KGs)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      )
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: htFeetController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.height),
                      label: Text('Feet'),
                      hintText: "Enter your Height(in Feet)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      )
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: htInchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.height),
                      label: Text('Inch'),
                      hintText: "Enter your Height(in Inch)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      )
                  ),
                ),
                SizedBox(
                    height: 21
                ),
                ElevatedButton(onPressed: () {
                  //calculate BMI here...
                  calculateBMI();
                }, child: Text('Calculate BMI')),
                SizedBox(
                  height: 5,
                ),

                imgPath!="" ? Image.asset(imgPath, height: 150, width: 150) : Container(),

                bmiScore==0.0
                    ? Container() :
                Text('Your BMI is ${bmiScore.toStringAsFixed(2)}', style : TextStyle(fontSize: 21)),

                bmiType == "" ? Container() : Text("You're $bmiType" ),
                SizedBox(
                  height: 50,
                ),
              ],
          ),
        )
    );
  }
  //BMI Calculation is here
  void calculateBMI(){
    var wt = int.parse(wtController.text.toString());
    var ft = int.parse(htFeetController.text.toString());
    var inch = int.parse(htInchController.text.toString());

    //ft and inch to m
    var totalInches = (ft * 12) + inch;

    var totalCM = totalInches * 2.54;

    var totalM = totalCM / 100;

    var bmi = wt / (pow(totalM, 2.0));

    //to get the type from BMI (HEALTHY, OVERWT, UNDERWT)
    if(bmi>25){
      bmiType = "Over Weight";
      bgColor = Colors.red.shade100;
      imgPath = "assets/images/overwt.jpg";

    } else if(bmi<18){
      bmiType = "Under Weight";
      bgColor = Colors.yellow.shade100;
      imgPath = "assets/images/underwt.jpg";
    } else {
      bmiType = "Healthy";
      bgColor = Colors.green.shade100;
      imgPath = "assets/images/healthy.jpg";
    }

    bmiScore = bmi;
    wtController.text = "";
    htFeetController.text = "";
    htInchController.text = "";
    setState(() {});
    print(bmi);
  }
}

