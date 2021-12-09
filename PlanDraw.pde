class PlandrawModel {
  PlanModel _plan;
  PlandrawModel (PlanModel plan){
    _plan = plan;
  }
  void drawFront(){
    pushMatrix();
    fill(156, 156, 156);
    my_translate(-50,0,0);
    my_box(50, 10, 10);
    popMatrix();
  
  }
  void drawCenter(){
    pushMatrix();
    
    fill(0, 156, 156);
    my_box(50, 10, 50);
    my_translate(-10, 12.5, 0);
    
    fill(120, 0, 10);
    sphere(5);
    popMatrix();
  }
  void drawBack(){
    pushMatrix();
    my_translate(35,0,0);
    fill(0, 255, 255);
    my_box(20, 10, 20);
    
    my_translate(0,10,0);
    fill(0, 0, 255);
    my_box(20, 10, 2);
    popMatrix();
  }
  void drawWingsL(){}
  void drawWingsR(){}
  
  
  void drawCentralMotorPush(){
    pushMatrix();
    float dy = _plan.currentfrontJetTrust / _plan.maxfrontJetTrust * 100; // 1 metter max
    my_translate(-plan.planFrontEngineLenght * 100 , -dy/2 -10/2, 0);
    fill(0, 255, 255);
    my_box(10, dy, 10);
    popMatrix();
  }
  
  void drawBackMotorPush(){
    pushMatrix();
    float dy = _plan.currentbackJetTrust / _plan.maxbackJetTrust * 100; // 1 metter max
    my_translate(plan.planBackEngineLenght * 100 , -dy/2 -10/2, 0);
    fill(0, 255, 255);
    rotateZ(_plan.zangle + HALF_PI);
    my_box(10, dy, 10);
    popMatrix();
  }
  
  
  void drawPlanShape() {
    pushMatrix();
    drawCentralMotorPush();
    drawBackMotorPush();
    drawFront();
    drawCenter();
    drawBack();
    drawWingsL();
    drawWingsR();
    popMatrix();
  }
}
