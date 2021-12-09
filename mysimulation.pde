
MyCamera cam = new MyCamera();
InputControl input = new InputControl();
PlanModel plan = new PlanModel();
flyControlModel flyControl = new flyControlModel(plan);
TelemetryUI telemetry = new TelemetryUI(plan); 

int timeMillis = 0;
void setup(){
  size(1200, 800, P3D);
  timeMillis = millis();
}

void draw() {
  int now = millis();
  int dt = now - timeMillis; 
  background(88,88,88);
  ambientLight(255, 255, 255,0,0,0);
  input.getAction();
  flyControl.applyInput(input);
  
  
  mapDraw();
  my_translate(0,100,0);
  plan.drawPlan(((float) dt)/1000);
  
  cam.cameraDraw(plan.position);
  
  telemetry.displayInfo();
  timeMillis = now;
  
}
