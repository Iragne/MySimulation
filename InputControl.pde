class InputControl {

  float topDown = 0.0;
  
  float step = 1;
  float maxTopDown = 180;
  float maxJoystick = 90;
  
  float forwardBack = 0.0;
  float rightLeft = 0.0;
  
//  float zrot = 0.0;
  float backTrust = 0.0;
  
 
  InputControl (){
    setToZero();
  }

  void setToZero(){
    forwardBack = 0.0;
    rightLeft = 0.0;
    //zrot = 0.0;
  }
  
  float moveControl(float value, float step, float min, float max) {
    if (value + step <= max && value + step >= min )
      return value + step;
      println("Max or min value achived");
    return value;
  }
  
  void getAction(){
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP) {
          // foward
          forwardBack = this.moveControl(forwardBack, step, -this.maxJoystick, this.maxJoystick);
        }
        if (keyCode == DOWN) {
          // back
          forwardBack = this.moveControl(forwardBack, -step, -this.maxJoystick, this.maxJoystick);
        }
        
        if (keyCode == LEFT) {
          // left
          rightLeft = this.moveControl(rightLeft, -step, -this.maxJoystick, this.maxJoystick);
        }
        if (keyCode == RIGHT) {
          // right
          rightLeft = this.moveControl(rightLeft, step, -this.maxJoystick, this.maxJoystick);
        }
        
        
      } else {
        if (key == 'o') {
          // down
          setToZero();
        }
        if (key == 'a') {
          // down
          topDown = this.moveControl(topDown, -step, 0, maxTopDown);
        }
        if (key == 'q') {
          // up
          topDown = this.moveControl(topDown, step, 0, maxTopDown);
        }
      }
    }else {
      
    } 
  }
  
  float getRationTopDown(){
    return topDown / maxTopDown;
  }
  
  
}
