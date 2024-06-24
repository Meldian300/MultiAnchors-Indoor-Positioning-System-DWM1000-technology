
// Fungsi untuk menggambar grid
void drawGrid(float startX, float startY, float endX, float endY, float step) {
  stroke(255,50); // Warna grid (hitam)
  
  // Menghitung ulang jumlah langkah grid berdasarkan ukuran layar
  int numVertical = int((endX - startX) / step);
  int numHorizontal = int((endY - startY) / step);
  
  // Menggambar grid sesuai dengan ukuran layar yang baru
  for (int i = 0; i <= numVertical; i++) {
    float x = startX + i * step;
    line(x, startY, x, endY); // Garis vertikal
  }
  
  for (int j = 0; j <= numHorizontal; j++) {
    float y = startY + j * step;
    line(startX, y, endX, y); // Garis horizontal
  }
}

void drawButton(float x, float y, float w, float h, String label) {
  // Menggambar tombol dengan persegi panjang dan teks di tengahnya
  rectMode(CENTER);
  fill(200); // Warna tombol
  rect(x, y, w, h, 10);
  fill(0); // Warna teks
  textSize(14);
  textAlign(CENTER, CENTER);
  text(label, x, y);
}

void drawCursor(){
  if( (mouseX >= 30 && mouseY >= 100) && (mouseX <= 1063 && mouseY <= 794))
  {
    // Menampilkan posisi kursor dan koordinat
    fill(255);
    textSize(20);
    textAlign(RIGHT);
    text("Mouse X: " + ((mouseX - (width - width + 30)) / scaleWidth), mouseX - width / 2, mouseY - height / 2);
    text("Mouse Y: " + (-(mouseY - (height / 2 + 70)) / scaleheight), mouseX - width / 2, mouseY - height / 2 + 20);
    
    // Indikator posisi kursor
    stroke(255);
    line(mouseX - width / 2, -(height / 2), mouseX - width / 2, height / 2); // Garis vertikal
    line(- (width / 2), mouseY - height / 2 , width / 2, mouseY - height / 2); // Garis horizontal
  }
}

void infoLabel(){
  // Menampilkan judul
  fill(255);
  textSize(25);
  textAlign(CENTER);
  text("Indoor Positioning System GUI", width / 2, 90);
 
  
  // Menampilkan informasi port dan baudrate
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Port: " + selectedPort, width / 2 + 300, height - (height - 80));
  text("Baudrate: " + baudRate, width / 2 + 300, height - (height - 60));
  
  // Menampilkan informasi Control
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Control : ", width - 300, height - 75);
  text("Record: press 'R'", width - 300, height - 50);
  text("Mode: press 'M'", width - 300, height - 30);
  text("Clear Screen: press 'C'", width - 300, height - 10);
  
}
