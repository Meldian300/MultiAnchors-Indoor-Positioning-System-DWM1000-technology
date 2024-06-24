// Variabel Kalman Filter
float Q = 0.1; // Variance proses
float R = 10.0; // Variance pengukuran

float x_est = 0.0; // Estimasi posisi X
float y_est = 0.0; // Estimasi posisi Y
float P_x = 1.0; // Estimasi error posisi X
float P_y = 1.0; // Estimasi error posisi Y
float K_x = 0.0; // Gain X
float K_y = 0.0; // Gain Y

// Fungsi Kalman Filter
void kalmanFilter(float measurementX, float measurementY, float &filteredX, float &filteredY) {
  // Prediksi
  float x_pred = x_est;
  float y_pred = y_est;

  P_x += Q; // Perkiraan error posisi X
  P_y += Q; // Perkiraan error posisi Y

  // Update
  K_x = P_x / (P_x + R); // Gain X
  K_y = P_y / (P_y + R); // Gain Y

  x_est = x_pred + K_x * (measurementX - x_est); // Koreksi posisi X
  y_est = y_pred + K_y * (measurementY - y_est); // Koreksi posisi Y

  P_x = (1 - K_x) * P_x; // Koreksi error posisi X
  P_y = (1 - K_y) * P_y; // Koreksi error posisi Y

  // Mengembalikan hasil estimasi X dan Y setelah difilter
  filteredX = x_est;
  filteredY = y_est;
}
