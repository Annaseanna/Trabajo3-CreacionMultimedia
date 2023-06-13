class Bolita {
  Bolita(){
  } 
  float[] mostrar(float cx, float cy,boolean jug){
    stroke(255);
    strokeWeight(4);
    if (jug) {
      image(player1,cx,cy);
    }
    else {
      image(player2,cx,cy);
    }
    float[] xd = {cx,cy};
    return xd;
  }
}
