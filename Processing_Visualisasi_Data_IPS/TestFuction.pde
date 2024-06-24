
void testCursor(){
  fill(255);
  textSize(20);
  textAlign(RIGHT);
  text("Mouse X: " + (mouseX - width / 2), mouseX - width / 2, mouseY - height / 2);
  text("Mouse Y: " + (mouseY - height / 2), mouseX - width / 2, mouseY - height / 2 + 20);
  
  // Indikator posisi kursor
  stroke(255);
  line(mouseX - width / 2, -(height / 2), mouseX - width / 2, height / 2); // Garis vertikal
  line(- (width / 2), mouseY - height / 2 , width / 2, mouseY - height / 2); // Garis horizontal
}
