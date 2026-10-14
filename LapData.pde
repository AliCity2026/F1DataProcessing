class LapData {

  String session;
  int lapNumber;
  float lapSeconds;

  float sector1;
  float sector2;
  float sector3;

  LapData(String session, int lapNumber, float lapSeconds,
          float sector1, float sector2, float sector3) {

    this.session = session;
    this.lapNumber = lapNumber;
    this.lapSeconds = lapSeconds;

    this.sector1 = sector1;
    this.sector2 = sector2;
    this.sector3 = sector3;
  }
}
