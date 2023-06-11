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
 }
 void anadirVecinos(){
   if(actFila>0){
     vecinos.add(bloques[actFila-1][actCol]);
   }
   if(actCol<columnas-1){
     vecinos.add(bloques[actFila][actCol+1]);
   }
   if(actFila>filas-1){
     vecinos.add(bloques[actFila+1][actCol]);
   }
   if(actCol>0){
     vecinos.add(bloques[actFila][actCol]);
   }
 }
 
 boolean vecinosSinVisitar(){
   for (Bloque vecino:vecinos){
     if 
   }
 }
}
