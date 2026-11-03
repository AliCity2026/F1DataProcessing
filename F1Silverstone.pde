
Table data;

float[] lapTimes;
float[] sortedTimes;

void setup() {

  size(1500, 950);

  // Read the data
  data = loadTable("f1_silverstone_valid_laps.csv", "header");

  // Save the lap times
  lapTimes = new float[data.getRowCount()];

  for (int i = 0; i < lapTimes.length; i++) {
    lapTimes[i] = data.getFloat(i, "lap_seconds");
  }

  // Sort the times
  sortedTimes = sort(lapTimes);
}

void draw() {

  background(255);

  int left = 150;
  int right = 1320;
  int top = 90;
  int bottom = 720;

  float fastest = getFastestLap(lapTimes);
  float slowest = sortedTimes[sortedTimes.length - 1];

  // Give the Y axis some space
  float minTime = floor(fastest * 10) / 10.0;
  float maxTime = ceil(slowest * 10) / 10.0;

  if (maxTime == minTime) {
    maxTime = minTime + 0.1;
  }

  // Title
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Silverstone - Lap Times", 60, 45);

  // Y axis time labels
  for (int i = 0; i <= 10; i++) {

    float seconds = minTime + i * (maxTime - minTime) / 10.0;

    float y = map(seconds, minTime, maxTime, bottom, top);

    int minutes = floor(seconds / 60);
    float remainingSeconds = seconds - minutes * 60;

    fill(0);
    textSize(12);
    textAlign(RIGHT, CENTER);

    text(minutes + ":" + nf(remainingSeconds, 2, 3),
         left - 15, y);
  }

  // X and Y axes
  stroke(0);
  strokeWeight(2);

  line(left, top, left, bottom);
  line(left, bottom, right, bottom);

  // Connecting the dots
  stroke(220, 0, 0);
  strokeWeight(2);
  noFill();

  beginShape();

  for (int i = 0; i < lapTimes.length; i++) {

    float x = map(i, 0, lapTimes.length - 1,
                  left, right);

    float y = map(lapTimes[i], minTime, maxTime,
                  bottom, top);

    vertex(x, y);
  }

  endShape();

  // Lap points
  for (int i = 0; i < lapTimes.length; i++) {

    float x = map(i, 0, lapTimes.length - 1,
                  left, right);

    float y = map(lapTimes[i], minTime, maxTime,
                  bottom, top);

    if (lapTimes[i] == fastest) {
      fill(0, 170, 0);
    } else {
      fill(220, 0, 0);
    }

    noStroke();
    circle(x, y, 10);

    // Lap numbers 1 to 25
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);

    text(i + 1, x, bottom + 25);
  }

  // X axis title
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);

  text("Lap Number", 735, 890);

  // Y axis title
  pushMatrix();
  translate(40, 460);
  rotate(-HALF_PI);
  text("Lap Time", 0, 0);
  popMatrix();

  noLoop();
}

// Find and return the fastest lap time
float getFastestLap(float[] times) {

  float fastest = times[0];

  for (int i = 1; i < times.length; i++) {

    if (times[i] < fastest) {
      fastest = times[i];
    }
  }

  return fastest;
}
