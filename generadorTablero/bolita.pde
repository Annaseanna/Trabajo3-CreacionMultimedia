class Bolita {
  Bolita(){
  } 
  float[] mostrar(float cx, float cy){
    stroke(255);
    strokeWeight(4);
    ellipse(cx,cy,20,20);
    float[] xd = {cx,cy};
    return xd;
  }
}
