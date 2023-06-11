//Valores globales
int columnas;
int filas;
int tam=40;
//Array de bloques
Bloque[][]bloques;
Bloque ahora;
boolean acabadoDeDibujar=false;


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
      Block siguiente = ahora.vecinoAleatorio();
      conjunto.add(ahora);
      ahora=siguiente;
    }
  } else {
    
  }
}
