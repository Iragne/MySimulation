class MyCamera {
  float mouseDistance = 500;
  float distanceZoom = 1000;
  float hClick = -1;
  
  void cameraDraw(PVector POV){
    beginCamera();
    
    if (mousePressed) {
      if (hClick < 0) {
        hClick = mouseY;
      }
      mouseDistance += (hClick - mouseY) * 0.1;
    } else {
      hClick = -1;
    }
    
    float distance = mouseDistance/float(height) * distanceZoom ;
    if (distance == 0.0) {
      distance = 100;
    }
    
    my_camera(0, 180, distance/2, POV.x * 100, POV.y * 100, POV.z * 100);
    //my_camera(0, 180, distance/2, 0, 0, 0);
    endCamera();
  }
  
}
