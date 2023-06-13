class Bolita {
  Bolita(){
  } 
  float[] mostrar(float cx, float cy,boolean jug){
    stroke(255);
    strokeWeight(4);
    if (jug) {
      image(player1,cx-20,cy-20);
    }
    else {
      image(player2,cx+20,cy+20);
    }
    float[] xd = {cx,cy};
    return xd;
  }
}
