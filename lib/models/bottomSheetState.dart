import 'package:dragtime/models/lightStep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetState with ChangeNotifier {
  bool redState;
  bool greenState;
  bool yellowState;
  int timer;
  List<LightStep> lightSteps = [];

  int get lightStepLength {
    return lightSteps.length;
  }

  BottomSheetState([
    this.redState = true,
    this.greenState = false,
    this.yellowState = false,
  ]);
  int get fase {
    return this.lightStepLength + 1;
  }

  void changeToRedState(bool val) {
    redState = val;
    greenState = false;
    yellowState = false;
    notifyListeners();
  }

  void changeToGreenState(bool val) {
    redState = false;
    greenState = val;
    yellowState = false;
    notifyListeners();
  }

  void changeToYellowState(bool val) {
    redState = false;
    greenState = false;
    yellowState = val;
    notifyListeners();
  }

  Color get actualColorStep {
    if (redState) return Colors.red;
    if (yellowState) return Colors.yellow;
    if (greenState) return Colors.green;
  }

  LightStep get bottomSheetResult {
    LightStep resultToReturn = LightStep(fase, actualColorStep, timer);
    return resultToReturn;
  }

  void resetLightSteps() {
    this.lightSteps = [];
    notifyListeners();
  }

  void setTimer(int _timer) {
    timer = _timer;
    notifyListeners();
  }

  void addLightStep(LightStep _lightStep) {
    lightSteps.add(_lightStep);
    notifyListeners();
  }
}
