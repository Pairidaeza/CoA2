awesome_face aw;
charFly cf;
kirby kb;

void setup(){
  size (800, 600);
  aw = new awesome_face(3);
  cf = new charFly(3,4);
  kb = new kirby();
}

void draw(){
  background(255);
  aw.show();
  aw.colour();
  cf.update();
  cf.jetFighter();
  kb.update();
  kb.show();
}

void keyPressed(){
  kb.move(key);
}
