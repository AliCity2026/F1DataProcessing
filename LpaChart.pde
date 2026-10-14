
class LapChart {

  void display(ArrayList<LapData> laps) {

    if (laps.size() == 0) return;

    fill(30);
    textSize(22);
    text("Silverstone - Lap Time Analysis", 45, 135);

    float left = 160;
    float right = width - 65;
    float top = 190;
    float bottom = height - 120;

    // Tum tur surelerini sirala
    FloatList times = new FloatList();

    for (LapData lap : laps) {
      times.append(lap.lapSeconds);
    }

    times.sort();

    // Tekrarlanan sureleri kaldir
    FloatList uniqueTimes = new FloatList();

    for (int i = 0; i < times.size(); i++) {
      if (i == 0 || abs(times.get(i) - times.get(i-1)) > 0.0005) {
        uniqueTimes.append(times.get(i));
      }
    }

    float fastest = uniqueTimes.get(0);

    // Y ekseni: Gercek sureler, esit araliklarla
    textAlign(RIGHT, CENTER);
    textSize(11);

    for (int i = 0; i < uniqueTimes.size(); i++) {

      float y = getY(i, uniqueTimes.size(), top, bottom);

      stroke(230);
      strokeWeight(1);
      line(left, y, right, y);

      fill(40);
      text(formatTime(uniqueTimes.get(i)), left - 12, y);
    }

    // Eksenler
    stroke(50);
    strokeWeight(2);
    line(left, top, left, bottom);
    line(left, bottom, right, bottom);

    // Tur surelerini birlestiren cizgi
    noFill();
    stroke(220, 45, 45);
    strokeWeight(2);

    beginShape();

    for (int i = 0; i < laps.size(); i++) {

      float x = getX(i, laps.size(), left, right);
      float y = getLapY(laps.get(i).lapSeconds,
                        uniqueTimes, top, bottom);

      vertex(x, y);
    }

    endShape();

    // Noktalar ve tur numaralari
    for (int i = 0; i < laps.size(); i++) {

      LapData lap = laps.get(i);

      float x = getX(i, laps.size(), left, right);
      float y = getLapY(lap.lapSeconds,
                        uniqueTimes, top, bottom);

      noStroke();

      if (abs(lap.lapSeconds - fastest) < 0.0005) {
        fill(0, 170, 80);
      } else {
        fill(220, 45, 45);
      }

      circle(x, y, 9);

      fill(30);
      textAlign(CENTER, TOP);
      textSize(12);
      text(i + 1, x, bottom + 12);
    }

    // Eksen isimleri
    fill(30);
    textAlign(CENTER, CENTER);
    textSize(16);

    text("Lap Number", (left + right) / 2, height - 43);

    pushMatrix();
    translate(25, (top + bottom) / 2);
    rotate(-HALF_PI);
    text("Lap Time (min:sec.ms)", 0, 0);
    popMatrix();

    textAlign(LEFT, BASELINE);
  }

  // X koordinati
  float getX(int index, int count, float left, float right) {
    return map(index, 0, max(1, count - 1), left, right);
  }

  // Y koordinati: Esit aralik
  float getY(int index, int count, float top, float bottom) {
    return map(index, 0, max(1, count - 1), bottom, top);
  }

  // Tur suresinin Y konumunu bul
  float getLapY(float seconds, FloatList times,
                float top, float bottom) {

    for (int i = 0; i < times.size(); i++) {

      if (abs(seconds - times.get(i)) < 0.0005) {
        return getY(i, times.size(), top, bottom);
      }
    }

    return bottom;
  }

  // Saniyeyi dakika formatina cevir
  String formatTime(float seconds) {
    int minutes = floor(seconds / 60);
    float rest = seconds - minutes * 60;

    return minutes + ":" + nf(rest, 2, 3);
  }
}
