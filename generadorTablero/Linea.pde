class Linea{
  float x1,x2;
  float y1,y2;
  boolean pos;
  
  //True horizontal false vertical
  Linea(float px1, float py1, float px2, float py2, boolean posicion){
    x1=px1;
    y1=py1;
    x2=px2;
    y2=py2;
    pos=posicion;
  }

  void drawLinea(){
    stroke(255);
    /*strokeCap(ROUND);
    smooth();*/
    line(x1,y1,x2,y2);
  }

}
