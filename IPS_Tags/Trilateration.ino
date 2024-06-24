float trilateration(float x1,float y1,float r1,float x2,float y2,float r2,float x3,float y3,float r3){
  float A = 2*x2 - 2*x1;
  float B = 2*y2 - 2*y1;
  float C = r1*r1 - r2*r2 - x1*x1 + x2*x2 - y1*y1 + y2*y2;
  float D = 2*x3 - 2*x2;
  float E = 2*y3 - 2*y2;
  float F = r2*r2 - r3*r3 - x2*x2 + x3*x3 - y2*y2 + y3*y3;

  current_tag_position[0] = (E*C - B*F) / (A*E - B*D);
  current_tag_position[1] = (A*F - D*C) / (A*E - B*D);

  return current_tag_position[0],current_tag_position[1];
}