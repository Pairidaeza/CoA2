class charFly{
  charFly(float a, float b){
    vx = a; vy = b;
    x = random(width);
    y = random(height);
    s = 1;
  }
  float x,y,vx,vy,s;
  void update(){ // change at every draw()
    x += vx; y += vy;
    if(x<0 || x>width) vx = -vx;
    if(y<0 || y>height) vy = -vy;
  }
  void jetFighter(){
  fill(0,4,53);  //dark navy
  beginShape();
  vertex(x, y-s*59);  //nose
  vertex(x-s*6, y-s*23);
  vertex(x-s*15, y-s*12);
  vertex(x-s*18, y+s);
  vertex(x-s*44, y+s*28);
  vertex(x-s*44, y+s*34);  //left wingtip
  vertex(x-s*40, y+s*37);
  vertex(x-s*23, y+s*41);
  vertex(x-s*31, y+s*50);
  vertex(x-s*30, y+s*54);
  vertex(x-s*16, y+s*58);
  vertex(x-s*13, y+s*46);
  vertex(x-s*9, y+s*55);
  vertex(x-s*5, y+s*47);
  vertex(x, y+s*58);  //thruster
  vertex(x+s*5, y+s*47);
  vertex(x+s*9, y+s*55);
  vertex(x+s*13, y+s*46);
  vertex(x+s*16, y+s*58);
  vertex(x+s*30, y+s*54);
  vertex(x+s*31, y+s*50);
  vertex(x+s*23, y+s*41);
  vertex(x+s*40, y+s*37);
  vertex(x+s*44, y+s*34);  //right wingtip
  vertex(x+s*44, y+s*28);
  vertex(x+s*18, y+s);
  vertex(x+s*15, y-s*12);
  vertex(x+s*6, y-s*23);
  vertex(x, y-s*59);  //nose
  endShape();
  }
}
