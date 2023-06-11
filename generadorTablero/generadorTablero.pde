//Valores globales
int columnas;
int filas;
int tam=80;

//Array de bloques
Bloque[][]bloques;
Bloque ahora;
boolean acabadoDeDibujar=false;
ArrayList<Bloque> conjunto=new ArrayList<Bloque>();


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
        bloques[i][j].mostrar();
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
      print("Laberinto finalizado");
      pintarUltimaFilaAleatoriamente();
      print(conjunto);
      noLoop();
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

void pintarUltimaFilaAleatoriamente() {
  print(columnas);
  int fila = height-(height/tam); // Última fila del laberinto
  int columnaAleatoria = floor(random(columnas)); 
  fill(0,0,255);
  rect(fila,columnaAleatoria*(width/tam),tam,tam);
}
