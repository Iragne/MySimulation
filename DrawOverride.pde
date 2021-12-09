
void my_rect (float a, float b, float c, float d){
  pushMatrix();
  rotateX(PI/2);
  rect(a,b,c,d);
  popMatrix();
}


void my_camera(float x,float  y,float  z,float  ox,float  oy,float  oz){
  camera(x, -y, z, ox, -oy, oz, 0.0, 1.0, 0.0);
}


void my_translate(float x,float  y,float  z){
  translate(x, -y, z);
}


void my_box(float w, float h, float d) {
  box(w, -h, d);
}
