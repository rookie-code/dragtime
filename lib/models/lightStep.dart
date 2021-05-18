import 'package:flutter/material.dart';

class LightStep {
  int id;
  int colore;
  int time;

  LightStep(this.id, this.colore, this.time);

  LightStep.fromMap(Map map) {
    this.id = map['id'];
    this.colore = map['colore'];
    this.time = map['time'];
  }
  Map toMap() {
    return {
      'id': this.id,
      'colore': this.colore,
      'time': this.time,
    };
  }
}
