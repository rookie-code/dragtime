import 'package:dragtime/models/lightStep.dart';
import 'package:flutter/cupertino.dart';

class LightStepState with ChangeNotifier {
  int actualColor;
  int actualTimer;
  List<LightStep> lightList = [];
  LightStep actualLightStep;
  int lightIndex = 0;

  void initLightStepState(List<LightStep> _lightList) {
    lightList = _lightList;
    actualLightStep = lightList[lightIndex];
    actualTimer = actualLightStep.time;
    actualColor = actualLightStep.colore;
  }

  void countDownTimer() {
    actualTimer--;
    if (actualTimer <= 0) {
      lightIndex++;
      if (lightIndex >= lightList.length) {
        lightIndex = 0;
      }
      updateLightState();
    }

    notifyListeners();
  }

  void forwardTimer() {
    actualTimer++;
    if (actualTimer >= lightList[lightIndex].time) {
      actualTimer = lightList[lightIndex].time;
    }
    notifyListeners();
  }

  void changeFase() {
    lightIndex++;
    if (lightIndex >= lightList.length) {
      lightIndex = 0;
    }
    updateLightState();
  }

  void updateLightState() {
    actualLightStep = lightList[lightIndex];
    actualColor = actualLightStep.colore;
    actualTimer = actualLightStep.time;
    notifyListeners();
  }
}
