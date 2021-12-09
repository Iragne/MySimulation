
void mapDraw(){
  pushMatrix();
//  noStroke();
  fill(0, 255, 0);
  my_rect(-500, -500, 1000, 1000);
  fill(255, 0, 0);  // Set fill to red
  my_translate(0, 1, 0);
  my_rect(-10, -10, 20, 20);
  popMatrix();
}
