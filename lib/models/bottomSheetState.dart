import 'package:dragtime/models/lightStep.dart';
import 'package:flutter/material.dart';

class BottomSheetState with ChangeNotifier {
  bool redState;
  bool greenState;
  bool yellowState;
  int timer = 0;
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

  void changeToRedState() {
    redState = !redState;
    greenState = false;
    yellowState = false;
    notifyListeners();
  }

  void changeToGreenState() {
    redState = false;
    greenState = !greenState;
    yellowState = false;
    notifyListeners();
  }

  void changeToYellowState() {
    redState = false;
    greenState = false;
    yellowState = !yellowState;
    notifyListeners();
  }

  int get actualColorStep {
    if (redState) return Colors.red.value;
    if (yellowState) return Colors.yellow.value;
    if (greenState) return Colors.green.value;
    // Default to red if none are true, or throw an exception if that's preferred
    return Colors.red.value;
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

  void timerAddOne() {
    timer++;
    notifyListeners();
  }

  void timerRemoveOne() {
    timer--;
    if (timer <= 0) {
      timer = 0;
    }
    notifyListeners();
  }

  void addLightStep(LightStep _lightStep) {
    lightSteps.add(_lightStep);
    notifyListeners();
  }

  void setLightSteps(List<LightStep> _listLight) {
    lightSteps = _listLight;
  }

  void updateLightStep(int index, LightStep _lightStep) {
    lightSteps[index] = _lightStep;
    notifyListeners();
  }

  void removeLightStep(int index) {
    lightSteps.removeAt(index);
    notifyListeners();
  }
}
