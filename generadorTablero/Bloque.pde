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
 void mostrar(){
   if (caminos[0]){
    line(x,y,x+tam,y);
   }
   if (caminos[1]){
    line(x+tam,y,x+tam,y+tam); 
   }
   if (caminos[2]){
    line(x+tam,y+tam,x,y+tam); 
   }
   if (caminos[3]){
    line(x,y+tam,x,y); 
   }
   if(tomadoPorLaberinto){ // pinta el camino recorrido (azul oscuro)
     noStroke();
     fill(255,50,255,95);
     rect(x,y,tam,tam);
     stroke(0);
   }
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
