//Valores globales
int columnas;
int filas;
int tam=80;
//array de lineas
//oki
ArrayList<Linea> datos_lineas;
//Array de bloques
Bloque[][]bloques;
Bloque ahora;
Bolita bolita = new Bolita();
boolean acabadoDeDibujar=false;
ArrayList<Bloque> conjunto=new ArrayList<Bloque>();
float[] posicionBolita;
int sensibilidad=10;

void setup(){
  size(480,480);
  filas=height/tam;
  columnas=width/tam;
  bloques= new Bloque[filas][columnas];
  
  //Creacion de bloques (lineas)
  for (int i=0;i<filas;i++){
    for (int j=0;j<columnas;j++){
      bloques[i][j] =new Bloque(i,j);
    }
  }
  for (int i=0;i<filas;i++){
    for (int j=0;j<columnas;j++){
      bloques[i][j].anadirVecinos();
    }
  }

  //Variable creada para controlar las que son tomadas por el laberinto
  ahora=bloques[0][0];
  ahora.tomadoPorLaberinto=true;
  
  frameRate(10);
}

void draw(){
  if (!acabadoDeDibujar){
    background(0,255,255);
    strokeWeight(4);
    //Mostrar la cuadricula
    for (int i=0;i<filas;i++){
      for (int j=0;j<columnas;j++){
        datos_lineas = bloques[i][j].mostrar();
      }
    }
    fill(193,50,193);
    rect(ahora.x,ahora.y,tam,tam);
    
    if(ahora.vecinosSinVisitar()){
      Bloque siguiente = ahora.vecinoAleatorio();
      conjunto.add(ahora);
      quitarParedes(ahora,siguiente);
      ahora=siguiente;
    } else if(conjunto.size()>0){
      Bloque siguiente = conjunto.get(conjunto.size()-1);
      conjunto.remove(siguiente);
      ahora =siguiente;
    } else {
      //print("Laberinto finalizado");
      //pintarUltimaFilaAleatoriamente();
      //noLoop();
    }
  }
  posicionBolita=bolita.mostrar(mouseX,mouseY);
  println("posicion x"+posicionBolita[0]);
  println("posicion y"+posicionBolita[1]);
  print("tamano datos "+datos_lineas.size());
  for (int i=0;i<datos_lineas.size();i++){
    if(datos_lineas.get(i).pos){
      if(posicionBolita[0]<datos_lineas.get(i).x1 & posicionBolita[0]>datos_lineas.get(i).x2){
        if(abs(posicionBolita[1]-datos_lineas.get(i).y1)<=sensibilidad){
          //SE ACTIVA
          println("toco linea horizontal");
          }  
        }
    }
    else{
      if(posicionBolita[1]<datos_lineas.get(i).y2 & posicionBolita[1]>datos_lineas.get(i).y1){
        if(abs(posicionBolita[0]-datos_lineas.get(i).x1)<=sensibilidad){
          println("toco linea vertical");
          //SE ACTIVA
        }  
      }
    }
  } 
}

void quitarParedes(Bloque ah,Bloque sig){
  int disx=ah.actFila - sig.actFila;
  int disy=ah.actCol - sig.actCol;
  //Si la disx es -1 es que se esta moviendo de izq a derecha
  if (disx == -1) {
    ah.caminos[1] = false;
    sig.caminos[3] = false;
  } 
  else if (disx == 1) {
    ah.caminos[3] = false;
    sig.caminos[1] = false;
  }
  if (disy== -1) {
    ah.caminos[2] = false;
    sig.caminos[0] = false;
  } 
  else if (disy == 1) {
    ah.caminos[0] = false;
    sig.caminos[2] = false;
  }
}
