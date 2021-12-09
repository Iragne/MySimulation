class flyControlModel{
  PlanModel _plan = null;
  int state = 1;
  float zangle = 0.0;
  float yangle = 0.0;
  float move = 10;

  flyControlModel(PlanModel plan){
    _plan = plan;
    initState();
  }


  void initState(){
     if (state == 1){
       zangle = -90;
     }
  }
  
  void applyInput(InputControl input){
    // get controls information 
    // State 1 manage assiette and manage move (angle limitation + speed rotation limitation + translation limitation )
    // 0 means not move 
    // state 2 fly-Quad => counter balance the assiete to change push vector to 0
    // 0 means not move 
    // correct the asset to be 10° all the time 
    // increase back push means moving forward to gain speed
    // no limitation of fron speed 
    // zero means no change of the assiet (10 ° Z)

    // minimise the vy acceleratoin to fly => 
    // alerons active 
    // Limit the angle that the plan can take : yes 
    // all zero + push  => keep VY to zero, more push mean vy = 0 (in Body frame) but correction of thust vector until state 3
    // 

    // State 3 fly => not conter ballance the assiette 
    float ratio = input.getRationTopDown();
    print("Ration push");
    println(ratio);
    float front = (plan.planBackEngineLenght*ratio)/plan.planFrontEngineLenght;
    float back = ratio;
    if (state == 1){
      if (front > 1) {
        front = 1;
        back = plan.planFrontEngineLenght/plan.planBackEngineLenght;
      } 
      plan.zangle = radians(zangle + move * input.forwardBack/input.maxJoystick);
      plan.yangle = radians(yangle + move * input.rightLeft/input.maxJoystick);
    }
    
    
    _plan.currentbackJetTrust = back;
    _plan.currentfrontJetTrust = front;
  }
}
