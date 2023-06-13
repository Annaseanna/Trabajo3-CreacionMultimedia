import netP5.*;
import oscP5.*;
OscP5 oscP5;
OscP5 oscPURE;
NetAddress pureDataAddress;

import controlP5.*;
float y;
float x;
float speed = 0.5;
float posx;
float posy;
PImage fondo;
PImage piso;
PImage generadorTablero;
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
PFont customFont;
int port=2020;

boolean inicio = true;

void setup(){
  oscPURE = new OscP5(this,11111);
  oscP5 = new OscP5(this, port);
  pureDataAddress = new NetAddress("localhost",11112);
  size(720,720);
  fondo = loadImage("fondo_inicio.png");
  piso = loadImage("piso60.png");
  generadorTablero=loadImage("generador_tablero.png");
  //creacion botones
  facil = new ControlP5(this);
  medio = new ControlP5(this);
  dificil = new ControlP5(this);
  customFont = createFont("Algerian", 25);
  facil.addButton("Facil")
    .setPosition(((1*width)/4)-90, 600)
    .setSize(120, 30)
    .setLabel("easy")
    .setFont(customFont);
  facil.setColorBackground(color(#216755));
    medio.addButton("Medio")
    .setPosition(((2*width)/4)-50, 600)
    .setSize(120, 30)
    .setLabel("medium")
    .setFont(customFont);
    medio.setColorBackground(color(#216755));
    dificil.addButton("Dificil")
    .setPosition((3*width)/4-20, 600)
    .setSize(120, 30)
    .setLabel("hard")
    .setFont(customFont);
    dificil.setColorBackground(color(#216755));
  frameRate(120);
}
//activar sonido
void sendStartMessage(){
  OscMessage startmessage = new OscMessage("/start");
  oscPURE.send(startmessage,pureDataAddress);
}
void keyPressed(){
  if (keyCode == 32 ){
    sendStartMessage();
  }
}
void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/multisense/orientation/pitch")){
    y = message.get(0).floatValue();
    println("y: "+message.get(0).floatValue());
  }
  if(message.checkAddrPattern("/multisense/orientation/roll")){
    x = message.get(0).floatValue();
    println("x :"+message.get(0).floatValue());
  }
}

void crearEscena(int dificultad){
  tam = dificultad;
  filas=height/tam;
  columnas=width/tam;
  bloques= new Bloque[filas][columnas];
  posicion_trofeo = int(tam/2 + int(random(1,columnas))*tam);
  posx = tam/2;
  posy = tam/2;
  
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

int ralentizador = -1;
void draw(){
  if(!acabadoDeDibujar){
    ralentizador++;
  } else {
    ralentizador = 10;
  }
  if(inicio){
    image(fondo,0,0);
  } else {
    if (ralentizador%10 == 0){
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
      if(!acabadoDeDibujar){
        image(generadorTablero,ahora.x+tam/4,ahora.y+tam/4);
      }
      
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
        acabadoDeDibujar = true;
        //print("Laberinto finalizado");
        //pintarUltimaFilaAleatoriamente();
        //noLoop();
      }
    } 
    if(acabadoDeDibujar) {
      fill(255);
      circle(posicion_trofeo,height - tam/2,tam/2 - 5);
      posx += x*speed;
      posy += y*speed*-1;
      posicionBolita = bolita.mostrar(posx,posy);
      println("posicion x"+posicionBolita[0]);
      println("posicion y"+posicionBolita[1]);
      print("tamano datos "+datos_lineas.size());
      for (int i=0;i<datos_lineas.size();i++){
        if(datos_lineas.get(i).pos){
          if(posicionBolita[0]<datos_lineas.get(i).x1 & posicionBolita[0]>datos_lineas.get(i).x2){
            if(abs(posicionBolita[1]-datos_lineas.get(i).y1)<=sensibilidad){
              posx = tam/2;
              posy = tam/2;
              }  
            }
        }
        else{
          if(posicionBolita[1]<datos_lineas.get(i).y2 & posicionBolita[1]>datos_lineas.get(i).y1){
            if(abs(posicionBolita[0]-datos_lineas.get(i).x1)<=sensibilidad){
              posx = tam/2;
              posy = tam/2;
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
