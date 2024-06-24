int nullX = width + 30;
int nullY = height + 100;

int gridH = 670;
int gridW = 800;

void setup() {
  size(1090, 890); // Ukuran jendela visualisasi
  serialSetup();
}

float scaleWidth = 20;
float scaleheight = 50;

int ModeSelect; // Status menampilkan bayangan tag

ArrayList<PVector> tagPositions = new ArrayList<PVector>();

int lastTime = 0;
int lastTime2 = 0;
int interval = 1000; // Interval dalam milidetik (1 detik)

void draw() {
  background(0); // Membersihkan layar setiap frame
  
  pushMatrix();
  translate( width - width + 30, height / 2 + 70);
  
  // Menggambar jejak posisi tag sebelumnya
  noFill();
  stroke(255, 100); // Warna bayangan dengan transparansi
  beginShape();
  for (PVector pos : tagPositions) {
    vertex(pos.x * scaleWidth, - (pos.y * scaleheight));
  }
  endShape();
  
  // Menggambar anchor dan tag
  for (int i = 0; i < anchorX.length; i++) {
    drawAnchor(anchorX[i] * scaleWidth, - anchorY[i] * scaleheight, "A" + (i+1));
  }
  
  for (int i = 0; i < anchorX.length; i++) {
    // Menampilkan keterangan posisi anchor dan tag dalam meter
    textSize(20);
    textAlign(LEFT);
    fill(0, 255, 255); // Warna biru untuk tag
    text("Tag: X=" + tagX + "m, Y=" + tagY + "m", - width/2 + 30 , height /2 - 80);
    textAlign(CENTER);
    fill(204, 102, 255); // Warna merah untuk anchor
    text("( " + anchorX[i] + " , " + anchorY[i] + ")", anchorX[i] * scaleWidth, -anchorY[i] * scaleheight + 20);
    
    d[i] = distance(anchorX[i], -anchorY[i], tagX , tagY);
    
    drawClosestDistanceLines(tagX , -tagY , anchorX, anchorY);
  }
  
  // Menggambar posisi tag 
  fill(0, 255, 0); // Warna hijau untuk posisi tag yang dihitung

  drawTag(tagX * scaleWidth, -(tagY * scaleheight), "Estimated Tag");
    
  if(ModeSelect == 1){
    // Menggambar bayangan titik lingkaran posisi tag
    if (millis() - lastTime >= 1000) {
      lastTime = millis();
      tagPositions.add(new PVector(tagX * scaleWidth, -(tagY * scaleheight)));
      recordData(tagX, tagY);
    }
  
    for (PVector pos : tagPositions) {
      fill(0, 255, 0, 100); // Warna hijau transparan untuk bayangan
      stroke(255);
      ellipse(pos.x, pos.y, 10, 10);  
    }
  }else if(ModeSelect == 2) 
    {
      tagPositions.add(new PVector(tagX, tagY));
       if (tagPositions.size() > 50) tagPositions.remove(0);         
    }
  popMatrix();
  
  pushMatrix();
  translate(width / 2,height / 2);
  //Cursor 
  drawCursor();
  
  //testCursor();
  popMatrix();
  // Menggambar grid
  drawGrid(30, 100, width - 30, height - 100, 10); // Menggambar grid dari (30, 30) ke (340, 340) dengan sel 10
  
  infoLabel();
  
  // Batasi jumlah posisi yang disimpan agar tidak terlalu panjang
  /*if (tagPositions.size() > 50) {
    tagPositions.remove(0);
  }*/
}
