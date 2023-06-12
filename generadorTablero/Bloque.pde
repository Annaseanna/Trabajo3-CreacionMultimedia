
class Bloque {
  //rectangulo que dibujara el tablero 
  int x;
  int y;
  int actFila;
  int actCol;
  boolean tomadoPorLaberinto=false;
  boolean[] caminos = {true,true,true,true};
  ArrayList<Bloque> vecinos=new ArrayList<Bloque>();
 Bloque(int fila, int colum){
   x=fila *tam;
   y=colum*tam;
   actFila=fila;
   actCol=colum;
 }
 ArrayList<Linea> mostrar(){
   //Array de lineas
   ArrayList<Linea> lineas=new ArrayList<Linea>();
   if (caminos[0]){
     Linea datos = new Linea(x,y,x+tam,y,true);
     datos.drawLinea();
     lineas.add(datos);
   }
   if (caminos[1]){
     Linea datos = new Linea(x+tam,y,x+tam,y+tam,false);
     datos.drawLinea();
     lineas.add(datos);
   }
   if (caminos[2]){
     Linea datos = new Linea(x+tam,y+tam,x,y+tam,true);
     datos.drawLinea();
     lineas.add(datos);
   }
   if (caminos[3]){
     Linea datos = new Linea(x,y+tam,x,y,false);
     datos.drawLinea();
     lineas.add(datos);
   }
   if(tomadoPorLaberinto){ // pinta el camino recorrido (azul oscuro)
     noStroke();
     fill(255,50,255,95);
     rect(x,y,tam,tam);
     stroke(0);
   }
   return lineas;
 }
 void anadirVecinos(){
   if(actFila>0){
     vecinos.add(bloques[actFila-1][actCol]);
   }
   if(actCol<columnas-1){
     vecinos.add(bloques[actFila][actCol+1]);
   }
   if(actFila<filas-1){
     vecinos.add(bloques[actFila+1][actCol]);
   }
   if(actCol>0){
     vecinos.add(bloques[actFila][actCol-1]);
   }
 }
 
 boolean vecinosSinVisitar(){
   for (Bloque vecino:vecinos){
     if(!vecino.tomadoPorLaberinto){
       return true;
     }
   }
   return false;
 }
 
 Bloque vecinoAleatorio(){
   Bloque veci = vecinos.get(floor(random(0,vecinos.size())));
   while(veci.tomadoPorLaberinto){
     vecinos.remove(veci);
     veci=vecinos.get(floor(random(0,vecinos.size())));
   }
   veci.tomadoPorLaberinto=true;
   vecinos.remove(veci);
   return veci;
 }
}
