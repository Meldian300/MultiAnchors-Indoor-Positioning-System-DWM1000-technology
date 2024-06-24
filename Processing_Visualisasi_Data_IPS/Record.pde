boolean recording = false;
ArrayList<String> recordedData = new ArrayList<String>();

void keyPressed() {
  if (key == 'r' || key == 'R') {
    recording = !recording; // Toggle recording state
    if (recording) {
      recordedData.clear(); // Clear previously recorded data
      println("Recording started...");
    } else {
      String[] linesArray = new String[recordedData.size()];
      linesArray = recordedData.toArray(linesArray);
      saveStrings("recorded_data.txt", linesArray);
      println("Recording stopped. Data saved as 'recorded_data.txt'");
    }
  }
  if (key == 'c' || key == 'C') {
    tagPositions.clear();
  }
  if (key == 'm' || key == 'M') {
    ModeSelect++;
    if (ModeSelect == 3) ModeSelect = 0;
  }
}

void recordData(float tagX, float tagY) {
  if (recording) {
    // Record data every 1 second
    String dataToRecord = tagX + " , " + tagY;
    recordedData.add(dataToRecord);
    println("Data recorded: " + dataToRecord);
  }
}
