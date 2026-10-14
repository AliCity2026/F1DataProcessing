class StatsPanel {

  void display(ArrayList<LapData> laps) {

    float fastest = laps.get(0).lapSeconds;
    float total = 0;

    LapData bestLap = laps.get(0);

    for (LapData lap : laps) {

      total += lap.lapSeconds;

      if (lap.lapSeconds < fastest) {
        fastest = lap.lapSeconds;
        bestLap = lap;
      }
    }

    float average = total / laps.size();

    fill(30);
    textSize(23);
    text("Statistics", 45, 140);

    textSize(20);
    text("Valid laps: " + laps.size(), 45, 210);
    text("Fastest lap: " + formatTime(fastest), 45, 260);
    text("Average lap: " + formatTime(average), 45, 310);

    text(
      "Fastest lap recorded in: " +
      bestLap.session + ", lap " + bestLap.lapNumber,
      45, 360
    );
  }

  String formatTime(float seconds) {

    int minutes = floor(seconds / 60);
    float rest = seconds - minutes * 60;

    return minutes + ":" + nf(rest, 2, 3);
  }
}
