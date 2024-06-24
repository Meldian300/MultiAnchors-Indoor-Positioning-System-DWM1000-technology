
float[] trilaterate(float x1, float y1, float x2, float y2, float x3, float y3, float d1, float d2, float d3) {
  float A = 2 * (x2 - x1);
  float B = 2 * (y2 - y1);
  float C = d1 * d1 - d2 * d2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2;

  float D = 2 * (x3 - x1);
  float E = 2 * (y3 - y1);
  float F = d1 * d1 - d3 * d3 - x1 * x1 + x3 * x3 - y1 * y1 + y3 * y3;

  float G = (A * E - D * B);
  if (abs(G) < 1e-6) {
    println("Tiga anchor pada garis lurus, tidak dapat ditentukan posisi tag.");
    return new float[]{};
  }

  float tagXCoord = (C * E - F * B) / G;
  float tagYCoord = (A * F - C * D) / G;

  return new float[]{tagXCoord, tagYCoord};
}
