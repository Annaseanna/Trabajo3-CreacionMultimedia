import oscP5.*;
OscP5 oscP5;
int port = 2020;
float y;
float x;
void setup() {
  oscP5 = new OscP5(this, port);
  size(800,600);
  background(0);
}
void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/multisense/orientation/pitch")){
    y = message.get(0).floatValue();
    println("y: "+message.get(0).floatValue());
  }
  if(message.checkAddrPattern("/multisense/orientation/roll")){
    x = message.get(0).floatValue();
    println("x :"+message.get(0).floatValue());
  }
}
float posx = width/2;
float posy = height/2;
float speed = 0.5;
void draw(){
  posx += x*speed;
  posy += y*speed*-1;
  background(0);
  fill(255);
  circle(posx,posy,30);
  }
