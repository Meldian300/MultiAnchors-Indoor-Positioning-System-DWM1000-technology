float[] anchorX = new float[9]; // Koordinat anchor X dalam meter
float[] anchorY = new float[9]; // Koordinat anchor Y dalam meter
float[] d = new float[9]; // Jarak antara anchor dan tag

String[] anchorLabels = {"A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9"}; // Label anchor

float tagX = 0.0, tagY = 0.0; // Koordinat tag dalam meter

// Fungsi untuk menggambar anchor
void drawAnchor(float x, float y, String label) {
  fill(255, 153, 0); // Warna merah untuk anchor
  ellipse(x, y, 10, 10); // Menggambar lingkaran kecil sebagai anchor
  fill(255, 153, 0);
  textAlign(CENTER);
  text(label, x , y - 15);
}

// Fungsi untuk menggambar tag
void drawTag(float x, float y, String label) {
  fill(255, 83, 26); // Warna biru untuk tag
  ellipse(x, y, 10, 10); // Menggambar lingkaran kecil sebagai tag
  fill(255);
  text(label, x + 15, y);
}

void drawDistanceLines(float x1, float y1, float x2, float y2, float distance) {
  // Menggambar garis dari anchor ke tag
  stroke(0, 255, 0,80); // Warna hijau untuk indikator jarak
  line(x1, y1, x2, y2); // Menggambar garis
  
  // Menambahkan teks jarak di tengah garis
  float lineMidX = (x1 + x2) / 2;
  float lineMidY = (y1 + y2) / 2;
  fill(255);
  textSize(12);
  textAlign(CENTER);
  text(nf(distance, 0, 2) + "m", lineMidX, lineMidY);
}

float distance(float x1, float y1, float x2, float y2) {
  return sqrt(sq(x2 - x1) + sq(y2 - y1));
}

void drawClosestDistanceLines(float tagX, float tagY, float[] anchorX, float[] anchorY) {
  float[] distances = new float[anchorX.length];
  
  // Menghitung jarak dari tag ke setiap anchor
  for (int i = 0; i < anchorX.length; i++) {
    distances[i] = distance(tagX, -tagY, anchorX[i], anchorY[i]);
  }
  
  // Menemukan tiga jarak terdekat
  int[] closestIndexes = new int[3];
  float[] closestDistances = new float[3];
  for (int i = 0; i < 3; i++) {
    float minDistance = Float.MAX_VALUE;
    int minIndex = -1;
    for (int j = 0; j < distances.length; j++) {
      if (distances[j] < minDistance) {
        boolean alreadyExists = false;
        for (int k = 0; k < i; k++) {
          if (j == closestIndexes[k]) {
            alreadyExists = true;
            break;
          }
        }
        if (!alreadyExists) {
          minDistance = distances[j];
          minIndex = j;
        }
      }
    }
    closestIndexes[i] = minIndex;
    closestDistances[i] = minDistance;
  }
  
  // Menampilkan garis untuk tiga jarak terdekat
  for (int i = 0; i < 3; i++) {
    int index = closestIndexes[i];
    if(index != -1) drawDistanceLines(anchorX[index] * scaleWidth, -anchorY[index] * scaleheight, tagX * scaleWidth, tagY * scaleheight, closestDistances[i]);
  }
}
