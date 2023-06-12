float cx = 0;      // circle position (set by mouse)
float cy = 0;
float movx = 0;
float movy = 0;


void setup(){
  size(480,480);
  background(0);
  stroke(255);
  strokeWeight(4);
  line(240,0,240,480);
}

void draw(){
  background(0);
  stroke(255);
  strokeWeight(4);
  line(240,0,240,480);
  cx = mouseX;
  cy = mouseY;
  //condicionales
  if(movy < 240 & 240 - movx <= 10){
    movy = cy;
  } else if(cx < 240) {
    movx = cx;
    movy = cy;
  }
  

  
  
  fill(0,150,255, 150);
  noStroke();
  ellipse(movx,movy, 20,20);
}
