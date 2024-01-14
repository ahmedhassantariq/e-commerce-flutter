import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class OrderCompletion extends StatefulWidget {
  final String trackingID;
  const OrderCompletion({
    required this.trackingID,
    super.key
  });

  @override
  State<OrderCompletion> createState() => _OrderCompletionState();
}

class _OrderCompletionState extends State<OrderCompletion> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }


  @override
  Widget build(BuildContext context) {
    _controllerCenter.play();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Order Completed", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: HexColor("#38C1CE"))),
            const SizedBox(height: 20),
            Text("Your Order Tracking ID is ${widget.trackingID}"),
            const SizedBox(height: 20),
            TextButton.icon(
                onPressed: () {Navigator.pop(context);},
                icon: Icon(Icons.thumb_up_alt, color: HexColor("#38C1CE"),),
            label: const Text("Okay")),

    SafeArea(
    child: Stack(
    children: <Widget>[
    //CENTER -- Blast
    Align(
    alignment: Alignment.center,
    child: ConfettiWidget(
    confettiController: _controllerCenter,
    blastDirectionality: BlastDirectionality
        .explosive, // don't specify a direction, blast randomly
    shouldLoop:
    true, // start again as soon as the animation is finished
    colors: const [
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.purple
    ], // manually specify the colors to be used
    createParticlePath: drawStar, // define a custom shape/path.
    ),
    ),

          ],
        ),
      ),
          ]
        )
      )
    );
  }
}
