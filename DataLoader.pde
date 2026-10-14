class DataLoader {

  ArrayList<LapData> loadLaps(String filename) {

    ArrayList<LapData> result = new ArrayList<LapData>();

    Table table = loadTable(filename, "header");

    if (table == null) return result;

    for (TableRow row : table.rows()) {

      LapData lap = new LapData(
        row.getString("session_id"),
        row.getInt("lap_number"),
        row.getFloat("lap_seconds"),
        row.getFloat("sector_1_seconds"),
        row.getFloat("sector_2_seconds"),
        row.getFloat("sector_3_seconds")
      );

      result.add(lap);
    }

    return result;
  }
}
