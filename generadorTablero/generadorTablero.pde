import controlP5.*;
//
PImage fondo;
//botones
ControlP5 facil;
ControlP5 medio;
ControlP5 dificil;
//Valores globales
int columnas;
int filas;
int tam=80;
int posicion_trofeo;
//array de lineas
//oki
ArrayList<Linea> dato_linea;
ArrayList<Linea> datos_lineas = new ArrayList<Linea>();
//Array de bloques
Bloque[][]bloques;
Bloque ahora;
Bolita bolita = new Bolita();
boolean acabadoDeDibujar=false;
ArrayList<Bloque> conjunto=new ArrayList<Bloque>();
float[] posicionBolita;
int sensibilidad=10;

boolean inicio = true;

void setup(){
  size(720,720);
  fondo = loadImage("fondo_inicio.png");
  //creacion botones
  facil = new ControlP5(this);
  medio = new ControlP5(this);
  dificil = new ControlP5(this);
  facil.addButton("Facil")
    .setPosition(100, 600)
    .setSize(80, 30)
    .setLabel("easy");
  facil.setColorBackground(color(#8F52F5));
    medio.addButton("Medio")
    .setPosition(320, 600)
    .setSize(80, 30)
    .setLabel("medium");
    medio.setColorBackground(color(#8F52F5));
    dificil.addButton("Dificil")
    .setPosition(540, 600)
    .setSize(80, 30)
    .setLabel("hard");
    dificil.setColorBackground(color(#8F52F5));
    
  frameRate(10);
}

void crearEscena(int dificultad){
  tam = dificultad;
  filas=height/tam;
  columnas=width/tam;
  bloques= new Bloque[filas][columnas];
  posicion_trofeo = int(tam/2 + int(random(1,columnas))*tam);
  
  //creacion de bloques
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
}

void Facil(){
  crearEscena(120);
  inicio = false;
  facil.remove("Facil"); 
  medio.remove("Medio");
  dificil.remove("Dificil");
}

void Medio(){
  crearEscena(80);
  inicio = false;
  facil.remove("Facil"); 
  medio.remove("Medio");
  dificil.remove("Dificil");
}
void Dificil(){
  crearEscena(60);
  inicio = false;
  facil.remove("Facil"); 
  medio.remove("Medio");
  dificil.remove("Dificil");
}

void draw(){
  if(inicio){
    image(fondo,0,0);
  } else {
    if (!acabadoDeDibujar){
      background(0,255,255);
      strokeWeight(4);
      //Mostrar la cuadricula
       datos_lineas = new ArrayList<Linea>();
      for (int i=0;i<filas;i++){
        for (int j=0;j<columnas;j++){
          dato_linea = bloques[i][j].mostrar();
          datos_lineas.addAll(dato_linea);
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
    fill(255);
    circle(posicion_trofeo,height - tam/2,tam/2 - 5);
    
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
   // println(abs(posicionBolita[1]- (height - tam/2))<tam/2 - 5);
    if(abs(posicionBolita[0]-posicion_trofeo)<tam/2 - 5 & abs(posicionBolita[1]- (height - tam/2))<tam/2 - 5){
      background(0);
      fill(255);
      textSize(128);
      text("GANASTE", width/10, height/2-30);
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
