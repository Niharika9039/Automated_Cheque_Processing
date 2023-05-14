import 'package:automated_cheque_processing/src/constants/image_strings.dart';
import 'package:automated_cheque_processing/src/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../HomeScreen.dart';
import '../../../../constants/colors.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool animate = false;

  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startAnimation();
  }

  @override
    Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? -50 : -100,
            left: animate ? -40 : -90,
            height: 200,
            width: 150,
            child: Image(
            image: AssetImage(tSplashTopIcon)),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: 30,
            left: animate ? 150 : -80,
            right: tDefaultSize, // Adjust the value to position the text as desired
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Column(
              children: [
                Text(
                  'Automated Cheque Processing !!',
                  textScaleFactor: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: tpink,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: 'Lobster',
                    shadows: [
                      Shadow(
                        color: tlightpink,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            left: animate ? 40 : -50,
            bottom: 40, // Adjust the value to position the text as desired
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
            child: Column(
              children: [
                Text(
                  'Scan your \n Cheque \nInstantly !!',
                  textScaleFactor: 2,
                  style: TextStyle(
                      fontSize: 14,
                    color: tpink,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: 'Lobster',
                    shadows: [
                      Shadow(
                        color: tlightpink,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
          AnimatedPositioned(
             duration: const Duration(milliseconds: 2400),
              height: 520,
              width: 460,
              top: animate ? 125 : -120,
              left: -28,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1:0,
              child: Image(image: AssetImage(tSplashImage)),
          ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            bottom: animate ? -55: 0,
            left: animate ? 280: 300,
            height: 180,
            width: 150,
            child: Image(
                image: AssetImage(tSplashTopIcon)),
          ),
        ],
      )
      ),
    );
  }

  Future startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

