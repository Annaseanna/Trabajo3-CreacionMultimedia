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
    int dist;
    stroke(#245045);
    strokeWeight(10);
    /*strokeCap(ROUND);
    smooth();*/
   line(x1,y1,x2,y2);
    if(pos){
      dist = int(abs(x1-x2));
      switch(dist){
        case 60:
          image(wallh,x1-5,y1-5);
          image(wallh,x1-5+20,y1-5);
          image(wallh,x1-5+40,y1-5);
          break;
        case 80:
          image(wallh,x1-5,y1-5);
          image(wallh,x1-5+20,y1-5);
          image(wallh,x1-5+40,y1-5);
          image(wallh,x1-5+60,y1-5);
          break;
        case 120:
          image(wallh,x1-5,y1-5);
          image(wallh,x1-5+20,y1-5);
          image(wallh,x1-5+40,y1-5);
          image(wallh,x1-5+60,y1-5);
          image(wallh,x1-5+80,y1-5);
          image(wallh,x1-5+100,y1-5);
          break;
      }
    } 
    if(!pos){
      dist = int(abs(y1-y2));
      switch(dist){
        case 60:
          image(wallv,x1-5,y1-5);
          image(wallv,x1-5,y1-5+20);
          image(wallv,x1-5,y1-5+40);
          break;
        case 80:
          image(wallv,x1-5,y1-5);
          image(wallv,x1-5,y1-5+20);
          image(wallv,x1-5,y1-5+40);
          image(wallv,x1-5,y1-5+60);
          break;
        case 120:
          image(wallv,x1-5,y1-5);
          image(wallv,x1-5,y1-5+20);
          image(wallv,x1-5,y1-5+40);
          image(wallv,x1-5,y1-5+60);
          image(wallv,x1-5,y1-5+80);
          image(wallv,x1-5,y1-5+100);
          break;
      }
    }
  }

}
