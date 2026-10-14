ArrayList<LapData> laps;

LapChart lapChart;
SectorChart sectorChart;
StatsPanel statsPanel;

int page = 1;

void setup() {
  size(1000, 750);
  textFont(createFont("Arial", 16));

  DataLoader loader = new DataLoader();
  laps = loader.loadLaps("f1_silverstone_valid_laps.csv");

  lapChart = new LapChart();
  sectorChart = new SectorChart();
  statsPanel = new StatsPanel();
}

void draw() {
  background(245);

  fill(25);
  textSize(28);
  text("F1 Silverstone - Dear Data 100", 45, 55);

  textSize(15);
  text("1: Lap Times     2: Sectors     3: Statistics", 45, 85);

  if (laps.size() == 0) {
    fill(180, 30, 30);
    text("No data found. Put CSV inside the sketch's data folder.", 45, 150);
    return;
  }

  if (page == 1) lapChart.display(laps);
  if (page == 2) sectorChart.display(laps);
  if (page == 3) statsPanel.display(laps);
}

void keyPressed() {
  if (key == '1') page = 1;
  if (key == '2') page = 2;
  if (key == '3') page = 3;
}
