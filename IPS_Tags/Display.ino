unsigned long pressStartTime;

void displayMenu(){
  // Tampilkan menu
  display.clearDisplay();
  display.setCursor(0, 0);
  if (!configMode) {
    // Mode normal
    display.println("Menu Konfigurasi");
    display.println("Anchor # " + String(currentAnchorIndex + 1));
    display.println("X: " + String(anchor_matrix[currentAnchorIndex][0]));
    display.println("Y: " + String(anchor_matrix[currentAnchorIndex][1]));
    display.println("Z: " + String(anchor_matrix[currentAnchorIndex][2]));
  } else {
    // Mode konfigurasi
    display.println("Mode Konfigurasi");
    display.println("Anchor # " + String(currentAnchorIndex + 1));
    if (currentConfigIndex == 0) {
      display.print("> ");
    }
    display.print("X: ");
    display.println(String(anchor_matrix[currentAnchorIndex][0]));
    if (currentConfigIndex == 1) {
      display.print("> ");
    }
    display.print("Y: ");
    display.println(String(anchor_matrix[currentAnchorIndex][1]));
    if (currentConfigIndex == 2) {
      display.print("> ");
    }
    display.print("Z: ");
    display.println(String(anchor_matrix[currentAnchorIndex][2]));
  }
  display.display();
}

void enterConfigMode(){
// Periksa tombol yang ditekan dengan debounce
  pressStartTime = millis();
  while (digitalRead(BACK_BUTTON_PIN) == LOW && digitalRead(OK_BUTTON_PIN) == LOW) {
    if (millis() - pressStartTime > LONG_PRESS_DELAY) {
      configMode = true; // Masuk mode konfigurasi
      lastDebounceTime = millis();
      break;
    }
  }
}

void handleConfigMode(){
  if (digitalRead(UP_BUTTON_PIN) == LOW) {
    // Tombol "Up" ditekan
    currentConfigIndex = (currentConfigIndex + 1) % 3;
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }
  else if (digitalRead(DOWN_BUTTON_PIN) == LOW) {
    // Tombol "Down" ditekan
    currentConfigIndex = (currentConfigIndex + 2) % 3;
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }
  else if (digitalRead(BACK_BUTTON_PIN) == LOW) {
    // Tombol "Back" ditekan
    anchor_matrix[currentAnchorIndex][currentConfigIndex] -= 0.1;
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }
  else if (digitalRead(OK_BUTTON_PIN) == LOW) {
    // Tombol "OK" ditekan
    anchor_matrix[currentAnchorIndex][currentConfigIndex] += 0.1;
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }

  if (configMode && digitalRead(UP_BUTTON_PIN) == LOW && digitalRead(DOWN_BUTTON_PIN) == LOW) {
  // Tombol "UP" dan "Down" ditekan bersamaan selama 3 detik
  pressStartTime = millis();
  bool configSaved = false;
  while (digitalRead(UP_BUTTON_PIN) == LOW && digitalRead(DOWN_BUTTON_PIN) == LOW) {
    if (millis() - pressStartTime > LONG_PRESS_DELAY) {
      // Simpan nilai konfigurasi
      configSaved = true;
      break;
    }
  }
  if (configSaved) {
    // Keluar dari mode konfigurasi
    configMode = false;
    saveAnchorPosition(anchor_matrix); // Simpan posisi anchor yang baru diubah ke EEPROM
    // Tampilkan pesan bahwa konfigurasi telah disimpan
    display.clearDisplay();
    display.setCursor(0, 0);
    display.println("Konfigurasi Disimpan");
    display.display();
    delay(2000); // Tahan pesan selama 2 detik sebelum kembali ke mode normal
    ESP.restart();
  }
  lastDebounceTime = millis();
  }

}

void handleNormalMode(){
  if (digitalRead(UP_BUTTON_PIN) == LOW) {
    // Tombol "Up" ditekan
    // Tambahkan logika untuk menyesuaikan nilai sesuai kebutuhan
    if (currentAnchorIndex < N_ANCHORS - 1) {
      currentAnchorIndex++;
    }
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }
  else if (digitalRead(DOWN_BUTTON_PIN) == LOW) {
    // Tombol "Down" ditekan
    // Tambahkan logika untuk menyesuaikan nilai sesuai kebutuhan
    if (currentAnchorIndex > 0) {
      currentAnchorIndex--;
    }
    lastDebounceTime = millis(); // Perbarui waktu debounce
  }
}