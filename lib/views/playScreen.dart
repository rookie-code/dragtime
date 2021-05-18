import 'package:circular_countdown/circular_countdown.dart';
import 'package:dragtime/main.dart';
import 'package:dragtime/models/bottomSheetState.dart';
import 'package:dragtime/models/lightStepState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatefulWidget {
  static const page = '/playScreen';
  PlayScreen({Key key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  AnimationController circleController;

  @override
  void initState() {
    super.initState();

    circleController = AnimationController(
      duration: Duration(seconds: 5),
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
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Color(
              Provider.of<LightStepState>(context, listen: false).actualColor),
          body: Column(
            children: <Widget>[
              Expanded(
                child: CircularCountdown(
                  textSpan: TextSpan(
                    text:
                        '${Provider.of<LightStepState>(context, listen: false).actualTimer.toString()}',
                    style: TextStyle(
                      backgroundColor: null,
                      fontSize: 500,
                      color: Colors.black,
                    ),
                  ),
                  countdownRemaining: circleController.value.toInt(),
                  countdownTotal: 60,
                  diameter: 650,
                  strokeWidth: 20,
                  countdownCurrentColor: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (RawKeyEvent event) {
                      if (event is RawKeyDownEvent &&
                          event.data is RawKeyEventDataAndroid) {
                        RawKeyDownEvent rawKeyDownEvent = event;
                        RawKeyEventDataAndroid rawKeyEventDataAndroid =
                            rawKeyDownEvent.data;
                        if (rawKeyEventDataAndroid.keyCode == 23) {
                          circleController.forward(from: 60);
                          setState(() {});
                        }
                      }
                    },
                    child: FloatingActionButton(
                      heroTag: 'less',
                      focusColor: Colors.black,
                      onPressed: () {
                        circleController.forward(from: 60);
                        setState(() {});
                      },
                      child: Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (RawKeyEvent event) {
                      if (event is RawKeyDownEvent &&
                          event.data is RawKeyEventDataAndroid) {
                        RawKeyDownEvent rawKeyDownEvent = event;
                        RawKeyEventDataAndroid rawKeyEventDataAndroid =
                            rawKeyDownEvent.data;
                        if (rawKeyEventDataAndroid.keyCode == 23) {
                          circleController.forward(from: 60);
                          Provider.of<LightStepState>(context, listen: false)
                              .forwardTimer();
                          setState(() {});
                        }
                      }
                    },
                    child: FloatingActionButton(
                        heroTag: 'add',
                        focusColor: Colors.black,
                        child: Icon(Icons.add),
                        onPressed: () {
                          circleController.forward(from: 60);
                          Provider.of<LightStepState>(context, listen: false)
                              .forwardTimer();
                          setState(() {});
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (RawKeyEvent event) {
                      if (event is RawKeyDownEvent &&
                          event.data is RawKeyEventDataAndroid) {
                        RawKeyDownEvent rawKeyDownEvent = event;
                        RawKeyEventDataAndroid rawKeyEventDataAndroid =
                            rawKeyDownEvent.data;
                        if (rawKeyEventDataAndroid.keyCode == 23) {
                          Provider.of<LightStepState>(context, listen: false)
                              .changeFase();
                        }
                      }
                    },
                    child: FloatingActionButton(
                      heroTag: 'changeScreen',
                      focusColor: Colors.black,
                      child: Icon(Icons.screen_share),
                      onPressed: () {
                        Provider.of<LightStepState>(context, listen: false)
                            .changeFase();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // pulsante per tornare alla pagina principale
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (RawKeyEvent event) {
                      if (event is RawKeyDownEvent &&
                          event.data is RawKeyEventDataAndroid) {
                        RawKeyDownEvent rawKeyDownEvent = event;
                        RawKeyEventDataAndroid rawKeyEventDataAndroid =
                            rawKeyDownEvent.data;
                        if (rawKeyEventDataAndroid.keyCode == 23) {
                          disposeController();
                          Navigator.pushNamed(context, MainMenu.page);
                        }
                      }
                    },
                    child: FloatingActionButton(
                        focusColor: Colors.black,
                        heroTag: 'backHome',
                        child: Icon(Icons.home),
                        onPressed: () {
                          disposeController();
                          Navigator.pushNamed(context, MainMenu.page);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
