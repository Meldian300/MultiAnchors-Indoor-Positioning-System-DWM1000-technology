void saveAnchorPosition(float data[][3]) {
  int addr = 0;
  for (int i = 0; i < N_ANCHORS; i++) {
    for (int j = 0; j < 3; j++) {
      EEPROM.put(addr, data[i][j]);
      addr += sizeof(float);
    }
  }
  EEPROM.commit(); // Simpan perubahan ke EEPROM
}

void loadAnchorPositions(float data[][3]) {
  int addr = 0;
  for (int i = 0; i < N_ANCHORS; i++) {
    for (int j = 0; j < 3; j++) {
      EEPROM.get(addr, data[i][j]);
      addr += sizeof(float);
    }
  }
}

void displayData(float data[][3]) {
  Serial.println("Data dari EEPROM:");
  for (int i = 0; i < N_ANCHORS; i++) {
    for (int j = 0; j < 3; j++) {
      Serial.print(data[i][j]);
      Serial.print("\t");
    }
    Serial.println();
  }
}