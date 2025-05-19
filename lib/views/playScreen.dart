import 'package:circular_countdown/circular_countdown.dart';
import 'package:dragtime/main.dart';
import 'package:dragtime/models/lightStepState.dart';
import 'package:dragtime/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatefulWidget {
  static const page = '/playScreen';
  PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  late AnimationController circleController;
  late int countDownTotal;

  @override
  void initState() {
    super.initState();
    countDownTotal =
        Provider.of<LightStepState>(context, listen: false).actualTimer ?? 60;

    circleController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
      upperBound: 60.0,
      lowerBound: 0.0,
    );

    circleController.addStatusListener((listener) {
      if (listener == AnimationStatus.completed) {
        circleController.value = 0.0;
        Provider.of<LightStepState>(context, listen: false).countDownTimer();
        circleController.forward();
      }
    });

    circleController.addListener(() {
      setState(() {});
    });

    circleController.forward();
  }

  void disposeController() {
    circleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Color(
                  Provider.of<LightStepState>(context, listen: false)
                      .actualColor) ??
              Color(Colors.white.toARGB32()),
          body: Stack(
            children: [
              Center(
                child: CircularCountdown(
                  textStyle: TextStyle(
                      fontSize: screenHeight * 0.7,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  countdownRemaining:
                      Provider.of<LightStepState>(context, listen: false)
                          .actualTimer,
                  countdownTotal: countDownTotal,
                  diameter: screenHeight * 0.95,
                  strokeWidth: 20,
                  countdownCurrentColor: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomActionButton(
                        focusColor: Colors.blueAccent,
                        heroTag: 'less',
                        icon: Icons.remove,
                        onPressed: () {
                          circleController.forward(from: 60);
                          setState(() {});
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    CustomActionButton(
                        focusColor: Colors.blueAccent,
                        heroTag: 'add',
                        icon: Icons.add,
                        onPressed: () {
                          Provider.of<LightStepState>(context, listen: false)
                              .forwardTimer();
                          setState(() {});
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    CustomActionButton(
                      focusColor: Colors.blueAccent,
                      heroTag: 'changeScreen',
                      icon: Icons.screen_share,
                      onPressed: () {
                        Provider.of<LightStepState>(context, listen: false)
                            .changeFase();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomActionButton(
                        focusColor: Colors.blueAccent,
                        heroTag: 'backHome',
                        icon: Icons.home,
                        onPressed: () {
                          disposeController();
                          Navigator.pushNamed(context, MainMenu.page);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
