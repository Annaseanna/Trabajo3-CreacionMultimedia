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
void draw(){
  background(0);
  fill(255);
  circle(width/2+x*2,height/2+y*2,30);
  }
