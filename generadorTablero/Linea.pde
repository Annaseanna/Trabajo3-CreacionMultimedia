class Linea{
  float x1,x2;
  float y1,y2;
  
  Linea(float px1, float py1, float px2, float py2){
    x1=px1;
    y1=py1;
    x2=px2;
    y2=py2;
  }

  void drawLinea(){
    line(x1,y1,x2,y2);
  }

}
