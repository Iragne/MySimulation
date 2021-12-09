class PlanModel {
  PlandrawModel _plan;
  //XYZ
  PVector f1 = new PVector(0,0,0); // back WF
  PVector f2 = new PVector(0,0,0); // front WF
  PVector f3 = new PVector(0,0,0); // right WF
  PVector f4 = new PVector(0,0,0); // left WF
  
  PVector force = new PVector(0,0,0); // sum
  
  PVector acceleration = new PVector(0,0,0); // xyz WF
  PVector position = new PVector(0,0,0); // xyz WF
  PVector velocity = new PVector(0,0,0);
  
  // rotation
  PVector rbfposition = new PVector(0,0,0); // radian angle BF
  PVector rbfacceleration = new PVector(0,0,0); // radian angle WF
  PVector rbfvelocity = new PVector(0,0,0); // angular speed BF
  
  // next position XYZ
  PVector c_position = new PVector(0,0,0);
  PVector c_velocity = new PVector(0,0,0);
  
  // next rotation
  PVector c_rposition = new PVector(0,0,0);
  PVector c_rvelocity = new PVector(0,0,0);
  
  PVector a_interntie = new PVector(0,0,0);
  
  
  float planWeight = 1.6; // KG
  float planBackEngineLenght = 0.3;
  float planFrontEngineLenght = 0.1;
  
  float backEngineWeight = 0.1;
  float frontEngineWeight = 0.1;
  
  float maxfrontJetTrust = 1.6;
  float maxbackJetTrust = 1.6;
  float maxrightTrust = 1.6;
  float maxleftTrust = 1.6;
  
  float currentfrontJetTrust = 0;
  float currentbackJetTrust = 0;
  float currentrightTrust = 0;
  float currentleftTrust = 0;
  
  float gravity = 9.8;
  float zangle = 0;
  float yangle = 0;
  
  
  
  PlanModel (){
     _plan = new PlandrawModel(this); 
     currentleftTrust = 0;
     currentrightTrust = 0;
     currentbackJetTrust = 0;
     currentfrontJetTrust = 0;
     a_interntie.z = backEngineWeight * planBackEngineLenght * planBackEngineLenght + frontEngineWeight * planFrontEngineLenght * planFrontEngineLenght;
     a_interntie.y = a_interntie.z;
     setBackVector(0, -HALF_PI);
     
  }
  
 void setBackVector(float y, float z){
   yangle = y;
   zangle = z;
 }
  
  // in World frame
  void drawPlan(float dt) {
    pushMatrix();
    // add linear translation
    this.applyLinearTranslation(dt);
    // add rotational translation
    _plan.drawPlanShape();
    
    popMatrix();
  }
  PVector rotate(PVector vector ,float f, float t, float o){
     PVector v = new PVector(vector.x, vector.y, vector.z);
      v.x = v.x * cos(o) - v.y * sin(o);
      v.y = v.x * sin(o) + v.y * cos(o);
      v.z = v.z;
      
      v.x = v.x * cos(t) + v.z * sin(t);
      v.y = v.y;
      v.z = -v.x * sin(t) + v.z * cos(t);
      
      
      v.x = v.x;
      v.y = v.y * cos(f) - v.z * sin(f);
      v.z = v.y * sin(f) + v.z * cos(t);
      return v;
   }

   PVector rotate_tr(PVector vector ,float f, float t, float o){
     PVector v = new PVector(vector.x, vector.y, vector.z);

      v.x = v.x * cos(o) + v.y * sin(o);
      v.y = -v.x * sin(o) + v.y * cos(o);
      v.z = v.z;
      
      v.x = v.x * cos(t) - v.z * sin(t);
      v.y = v.y;
      v.z = v.x * sin(t) + v.z * cos(t);
      
      
      v.x = v.x;
      v.y = v.y * cos(f) + v.z * sin(f);
      v.z = -v.y * sin(f) + v.z * cos(f);

      return v;
   }


  
  // claculate directional thrust vector in the body frame
  PVector getBackVectorForceBF(){
      PVector ret = new PVector(0,0,0);
      float backEngineForce = gravity * currentbackJetTrust * (maxbackJetTrust + backEngineWeight);
      ret.y =  - cos(yangle) * backEngineForce * sin(zangle);
      ret.x = - cos(yangle) * backEngineForce * cos(zangle);
      ret.z = - sin(yangle) * backEngineForce;
      
      return ret;
  }
   
  
 
  // from Body Frame
  PVector getFrontForceBF(){
    PVector ret = new PVector(0,0.0);
    float frontEngineForce = gravity * currentfrontJetTrust * (maxfrontJetTrust + frontEngineWeight);
    ret.y = frontEngineForce;
    ret.x = 0;
    ret.z = 0;
    
    return ret;
  }
  
   // from world Frame
  PVector getBackForceWF(){
      PVector v = getBackVectorForceBF();
      float o = rbfposition.x;
      float t = rbfposition.y;
      float f = rbfposition.z;
      // rotate the vector int the world frame
      v = this.rotate(v, o, t, f);
       f2 = v;
      return v;
  }
   // from world Frame
  PVector getFrontForceWF(){
      PVector v = getFrontForceBF();
      float o = rbfposition.x;
      float t = rbfposition.y;
      float f = rbfposition.z;
      v = this.rotate(v, o, t, f);
      f1 = v;
      return v;
  }
  
  PVector getWFForce(){
    PVector f1 = getFrontForceWF();
    PVector f2 = getBackForceWF();
    
    float push = f1.y + f2.y;
    force.y =  f1.y + f2.y;
    force.x =  f1.x + f2.x;
    force.z =  f1.z + f2.z;
    
    return force;
  }
  
  
  

  
  void applyLinearTranslation(float dt){
    this.getWFForce();
    float ax =  force.x / this.planWeight;
    float ay = -this.gravity  + force.y / this.planWeight; //<>//
    float az =  force.z / this.planWeight;
    
    this.acceleration.y = ay;
    this.acceleration.x = ax;
    this.acceleration.z = az;
    
    float vx =  ax * dt + velocity.x;
    float vy =  ay * dt + velocity.y;
    float vz =  az * dt + velocity.z;
    
    float dy =  0.5 * ay * dt * dt  + velocity.y * dt + position.y;
    float dx =  0.5 * ax * dt * dt  + velocity.x * dt + position.x;
    float dz =  0.5 * az * dt * dt  + velocity.z * dt + position.z;
    
    
    PVector mf1 = getFrontForceBF();
    PVector mf2 = getBackVectorForceBF();
    
    float mz = planBackEngineLenght * mf2.y - planFrontEngineLenght * mf1.y;
    float my = planBackEngineLenght * mf2.z - planFrontEngineLenght * mf1.z;
    float mx = 0;
    // mx == 0 => no force apply
    // mx != 0 => force 
    float arz = mz / a_interntie.z;
    float ary = my / a_interntie.y;
    float arx = mx / a_interntie.x;
    
    float wz = arz * dt + rbfvelocity.z ;
    float wy = ary * dt + rbfvelocity.y ;
    float wx = arx * dt + rbfvelocity.x ;
    
    float tetaz = 0.5 * arz * dt * dt  + rbfvelocity.z * dt + rbfposition.z;
    float tetay = 0.5 * ary * dt * dt  + rbfvelocity.y * dt + rbfposition.y;
    float tetax = 0.5 * arx * dt * dt  + rbfvelocity.x * dt + rbfposition.x;
    
    tetaz = tetaz % (2 * PI);
    tetay = tetay % (2 * PI);
    tetax = tetax % (2 * PI);
    
    
    
    if (dy >= 0){
      velocity.x = vx;
      velocity.y = vy;
      velocity.z = vz;
      
      position.x = dx;
      position.y = dy;
      position.z = dz;
      
      rbfvelocity.z = wz;
      rbfposition.z = tetaz;
      
      rbfvelocity.y = wy;
      rbfposition.y = tetay;
      
      
      
    } else {
      velocity.x = 0;
      velocity.y = 0;
      velocity.z = 0;
      
      position.x = 0;
      position.y = 0;
      position.z = 0;
      
      rbfposition.z = 0;
      rbfvelocity.z = 0;
      
      rbfposition.y = 0;
      rbfvelocity.y = 0;
      
    }
      
    
    
    my_translate(position.x * 100, position.y * 100, position.z * 100); //<>//
    rotateY(rbfposition.y);
    rotateZ(-rbfposition.z);
    
  }
  
}
