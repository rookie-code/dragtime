class LightStep {
  int id;
  int colore;
  int time;

  LightStep(this.id, this.colore, this.time);

  LightStep.fromMap(Map map)
      : id = map['id'],
        colore = map['colore'],
        time = map['time'];
  Map toMap() {
    return {
      'id': this.id,
      'colore': this.colore,
      'time': this.time,
    };
  }
}
