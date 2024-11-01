class awesome_face {
  float x, y, d=1, R=255, G=100, B=100, cv;
  float state; // colour 함수에 사용되는 변수
  
  awesome_face(float a) {
    cv = a;
    x = random(50, width - 50);
    y = random(50, height - 50);
  }
  
  void show() {
    stroke(0);
    strokeWeight(3*d);
    fill(R, G, B);
    circle(x,y,100*d); // face
  
    fill(255);
    arc(x-27.5*d,y-5*d,25*d,40*d,PI,2*PI);
    line(x-40*d,y-5*d,x-15*d,y-5*d); // left eye
  
    arc(x+17.5*d,y-5*d,25*d,40*d,PI,2*PI);
    line(x+5*d,y-5*d,x+30*d,y-5*d); // right eye
  
    fill(0);
    circle(x-22*d,y-17*d,9*d); // left pupil
  
    circle(x+23*d,y-17*d,9*d); // right pupil
  
    fill(136,18,67);
    arc(x-2.5*d,y+5*d,65*d,65*d,0,PI);
    line(x-40*d,y+5*d,x+30*d,y+5*d); // mouth
  
    fill(249,191,222);
    strokeWeight(0);
    pushMatrix();
    translate(x+5*d,y+30*d);
    rotate(-PI/12);
    ellipse(0,0,27*d,15*d);
    popMatrix(); // tongue
  
    strokeWeight(3*d);
    noFill();
    arc(x-2.5*d,y+5*d,65*d,65*d,0,PI); // mouth outline
  }
  
  void colour() {
    if(R >= 255) state = 1;
    else if(G >= 255) state = 2;
    else if(B >= 255) state = 3;
    
    if(state == 1){
      R -= cv; G += cv; B = 100;
    }
    else if(state == 2){
      R = 100; G -= cv; B += cv;
    }
    else if(state == 3){
      R += cv; G = 100; B -= cv;
    }
  }
}
