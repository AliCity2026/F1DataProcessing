class SectorChart {

  void display(ArrayList<LapData> laps) {

    fill(30);
    textSize(21);
    text("Average sector times", 45, 135);

    float s1 = 0;
    float s2 = 0;
    float s3 = 0;

    for (LapData lap : laps) {
      s1 += lap.sector1;
      s2 += lap.sector2;
      s3 += lap.sector3;
    }

    s1 /= laps.size();
    s2 /= laps.size();
    s3 /= laps.size();

    drawBar("Sector 1", s1, 230, color(220, 55, 55));
    drawBar("Sector 2", s2, 350, color(55, 110, 210));
    drawBar("Sector 3", s3, 470, color(35, 165, 110));

    fill(80);
    textSize(14);
    text("Bars represent sector duration, not performance loss.", 45, 565);
  }

  void drawBar(String label, float seconds, int y, int barColor) {

    fill(30);
    textSize(16);
    text(label, 45, y);

    fill(barColor);
    rect(185, y - 20, seconds * 15, 32);

    fill(30);
    text(nf(seconds, 0, 3) + " s", 200 + seconds * 15, y);
  }
}
