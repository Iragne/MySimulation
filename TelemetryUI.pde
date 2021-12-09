

class TelemetryUI {
  float fx = 0.0;
  float fy = 0.0;
  float fz = 0.0;
  
  
  float ax = 0.0;
  float ay = 0.0;
  float az = 0.0;
  
  float vx = 0.0;
  float vy = 0.0;
  float vz = 0.0;
  
  float x = 0.0;
  float y = 0.0;
  float z = 0.0;


  float rax = 0.0;
  float ray = 0.0;
  float raz = 0.0;
  
  float wx = 0.0;
  float wy = 0.0;
  float wz = 0.0;


  float teta_x = 0.0;
  float teta_y = 0.0;
  float teta_z = 0.0;
  
  PImage side_view_x;
  PImage side_view_y;
  PImage side_view_z;

  PGraphics pg;
  
  PlanModel _plan = null;
  
  TelemetryUI(PlanModel plan){
    _plan = plan;
  }
  
  void initImages(){
    side_view_z = loadImage("side-plan.png");
    side_view_z.resize(100,100);
    side_view_y = loadImage("top-plan.jpg");
    side_view_y.resize(100,100);
    side_view_x = loadImage("front-plan.png");
    side_view_x.resize(100,100);
  }
  
  void updateValue(){
    
    fx = _plan.force.x;
    fy = _plan.force.y;
    fz = _plan.force.z;
    
    x = _plan.position.x;
    y = _plan.position.y;
    z = _plan.position.z;
    
    ax = _plan.acceleration.x;
    ay = _plan.acceleration.y;
    az = _plan.acceleration.z;
    
    vx = _plan.velocity.x;
    vy = _plan.velocity.y;
    vz = _plan.velocity.z;

    rax = _plan.rbfacceleration.x;
    ray = _plan.rbfacceleration.y;
    raz = _plan.rbfacceleration.z;

    wx = _plan.rbfvelocity.x;
    wy = _plan.rbfvelocity.y;
    wz = _plan.rbfvelocity.z;

    teta_x = degrees(_plan.rbfposition.x);
    teta_y = degrees(_plan.rbfposition.y);
    teta_z = degrees(_plan.rbfposition.z);


  }
  
  void displayInfo() {
    if (side_view == null) {
      initImages();
    }
    this.updateValue();
    pg = createGraphics(width, 200);
    pg.beginDraw();
    //pg.rotate(PI/20);
    
    int columnWidth = 120;
    int space = 12;
    int col = 0;
    int padding = 10;
    //pg.background(0, 0, 255);
    pg.pushMatrix();
    pg.text("fx : " + str(fx), padding, space);
    pg.text("fy : " + str(fy), padding, space * 2);
    pg.text("fz : " + str(fz), padding, space * 3);
    
    pg.text("f1x : " + str(_plan.f1.x), padding, space * 5);
    pg.text("f1y : " + str(_plan.f1.y), padding, space * 6);
    pg.text("f1z : " + str(_plan.f1.z), padding, space * 7);
    
    pg.text("f2x : " + str(_plan.f2.x), padding, space * 9);
    pg.text("f2y : " + str(_plan.f2.y), padding, space * 10);
    pg.text("f2z : " + str(_plan.f2.z), padding, space * 11);
    
    
    pg.text("bY°: " + str(degrees(_plan.yangle)), padding, space * 13);
    pg.text("bZ°: " + str(degrees(_plan.zangle)), padding, space * 14);
    
    
    
    pg.text("x : " + str(x), padding + columnWidth, space);
    pg.text("y : " + str(y), padding + columnWidth, space * 2);
    pg.text("z : " + str(z), padding + columnWidth, space * 3);
    
    pg.text("ax : " + str(ax), padding + columnWidth, space * 5);
    pg.text("ay : " + str(ay), padding + columnWidth, space * 6);
    pg.text("az : " + str(az), padding + columnWidth, space * 7);

    pg.text("vx : " + str(vx), padding + columnWidth, space * 9);
    pg.text("vy : " + str(vy), padding + columnWidth, space * 10);
    pg.text("vz : " + str(vz), padding + columnWidth, space * 11);

    // Rotation 
    col = 2;
    pg.text("rax : " + str(rax), padding + (columnWidth + padding)  * col, space * 1);
    pg.text("ray : " + str(ray), padding + (columnWidth + padding) * col, space * 2);
    pg.text("raz : " + str(raz), padding + (columnWidth + padding) * col, space * 3);

    pg.text("wx : " + str(wx), padding + (columnWidth + padding) * col, space * 5);
    pg.text("wy : " + str(wy), padding + (columnWidth + padding) * col, space * 6);
    pg.text("wz : " + str(wz), padding + (columnWidth + padding) * col, space * 7);


    pg.text("t_x : " + str(teta_x), padding + (columnWidth + padding) * col, space * 9);
    pg.text("t_y : " + str(teta_y), padding + (columnWidth + padding) * col, space * 10);
    pg.text("t_z : " + str(teta_z), padding + (columnWidth + padding) * col, space * 11);

    col = col + 1;
    pg.pushMatrix();
    pg.translate(padding + (columnWidth + padding) * col, 50 + space * 1);
    pg.rotate(radians(-HALF_PI - teta_z));
    pg.image(side_view_z, -50, -50);
    pg.popMatrix();
    
    col = col + 1;
    pg.pushMatrix();
    pg.translate(padding + (columnWidth + padding) * col, 50 + space * 1);
    pg.rotate(radians(-HALF_PI - teta_y));
    pg.image(side_view_y, -50, -50);
    pg.popMatrix();
    
    col = col + 1;
    pg.pushMatrix();
    pg.translate(padding + (columnWidth + padding) * col, 50 + space * 1);
    pg.rotate(radians(-HALF_PI - teta_x));
    pg.image(side_view_x, -50, -50);
    pg.popMatrix();
    
    pg.endDraw();
    
    set(0, 0, pg);
    
    /*pushMatrix();
    rotate(HALF_PI);
    set(0,0, side_view);
    rotate(HALF_PI);
    popMatrix();*/
    
  }
}
