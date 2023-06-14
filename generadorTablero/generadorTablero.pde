import netP5.*;
import oscP5.*;
OscP5 oscP5;
OscP5 oscPURE;
NetAddress pureDataAddress;

import controlP5.*;
float y1;
float x1;
float y2;
float x2;
float speed = 0.05;
float posx1;
float posy1;
float posx2;
float posy2;
PImage fondo;
PImage piso60;
PImage piso80;
PImage piso120;
PImage generadorTablero;
PImage cuadricula;
PImage ganador;
PImage player1;
PImage player2;
//botones
ControlP5 facil;
ControlP5 medio;
ControlP5 dificil;
//Valores globales
int columnas;
int filas;
int tam=80;
int posicion_trofeo;
//true jug1 false jug 2
boolean bolita=true;
//array de lineas
//oki
ArrayList<Linea> dato_linea;
ArrayList<Linea> datos_lineas = new ArrayList<Linea>();
//Array de bloques
Bloque[][]bloques;
Bloque ahora;
Bolita bolita1 = new Bolita();
Bolita bolita2 = new Bolita();
boolean acabadoDeDibujar=false;
ArrayList<Bloque> conjunto=new ArrayList<Bloque>();
float[] posicionBolita1;
float[] posicionBolita2;
int sensibilidad=20;
PFont customFont;
int port=2020;
boolean gano;

boolean inicio = true;

void setup(){
  oscPURE = new OscP5(this,11111);
  oscP5 = new OscP5(this, port);
  pureDataAddress = new NetAddress("localhost",11112);
  size(720,720);
  fondo = loadImage("fondo_inicio.png");
  piso60 = loadImage("piso60.png");
  piso80 = loadImage("piso80.png");
  piso120 = loadImage("piso120.png");
  player1 = loadImage("player1.png");
  player2 = loadImage("player2.png");
  generadorTablero=loadImage("generador_tablero.png");
  cuadricula=loadImage("cuadricula.png");
  ganador=loadImage("ganador.png");
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
    y1 = message.get(0).floatValue();
    println("y: "+message.get(0).floatValue());
  }
  if(message.checkAddrPattern("/multisense/orientation/roll")){
    x1 = message.get(0).floatValue();
    println("x :"+message.get(0).floatValue());
  }
  if(message.checkAddrPattern("/multisense/orientation/pitch1")){
    y2 = message.get(0).floatValue();
    println("y1: "+message.get(0).floatValue());
  }
  if(message.checkAddrPattern("/multisense/orientation/roll1")){
    x2 = message.get(0).floatValue();
    println("x1 :"+message.get(0).floatValue());
  }
}

void crearEscena(int dificultad){
  tam = dificultad;
  filas=height/tam;
  columnas=width/tam;
  bloques= new Bloque[filas][columnas];
  posicion_trofeo = int(tam/2 + int(random(1,columnas))*tam);
  posx1 = tam/2;
  posy1 = tam/2;
  posx2 = tam/2;
  posy2 = tam/2;
  
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
      image(cuadricula,720,720);
      background(0,255,255);
      image(cuadricula,0,0);
      //Mostrar la cuadricula
       datos_lineas = new ArrayList<Linea>();
      for (int i=0;i<filas;i++){
        for (int j=0;j<columnas;j++){
          dato_linea = bloques[i][j].mostrar();
          datos_lineas.addAll(dato_linea);
        }
      }
      if(!acabadoDeDibujar){
        fill(#808110);
        noStroke();
        if (tam==120){
          image(generadorTablero,ahora.x+tam/4,ahora.y+tam/4);
        }
        if (tam==80){
          image(generadorTablero,ahora.x+tam/8,ahora.y+tam/8);
        }
        if (tam==60){
          image(generadorTablero,ahora.x,ahora.y);
        }
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
      if(tam==60){
        image(ganador,posicion_trofeo+tam/2,height - tam);
      }
      if(tam==80){
        image(ganador,posicion_trofeo-tam/3,height - tam+(tam/6));
      }
      if(tam==120){
        image(ganador,posicion_trofeo-(tam/4),height - tam+(tam/4));
      }
      posx1 += x1*speed;
      posy1 += y1*speed*-1;
      posx2 += x2*speed;
      posy2 += y2*speed*-1;
      //boolean gano1=colision(x1,y1,posx1,posy1,posicionBolita1,bolita1,true);
      posicionBolita1 = bolita1.mostrar(posx1,posy1,true);
      println("posicion x"+posicionBolita1[0]);
      println("posicion y"+posicionBolita1[1]);
      print("tamano datos "+datos_lineas.size());
      for (int i=0;i<datos_lineas.size();i++){
        if(datos_lineas.get(i).pos){
          if(posicionBolita1[0]<datos_lineas.get(i).x1 & posicionBolita1[0]>datos_lineas.get(i).x2){
            if(abs(posicionBolita1[1]-datos_lineas.get(i).y1)<=sensibilidad){
              posx1 = tam/2;
              posy1 = tam/2;
              }  
            }
        }
        else{
          if(posicionBolita1[1]<datos_lineas.get(i).y2 & posicionBolita1[1]>datos_lineas.get(i).y1){
            if(abs(posicionBolita1[0]-datos_lineas.get(i).x1)<=sensibilidad){
              posx1 = tam/2;
              posy1 = tam/2;
            }  
          }
        }
        if(abs(posicionBolita1[0]-posicion_trofeo)<tam/2 - 5 & abs(posicionBolita1[1]- (height - tam/2))<tam/2 - 5){
          background(0);
          fill(255);
          textSize(128);
          text("GANASTE 1", width/10, height/2-30);
          noLoop();
        }
      }
      posicionBolita2 = bolita2.mostrar(posx2,posy2,false);
      println("posicion x"+posicionBolita1[0]);
      println("posicion y"+posicionBolita1[1]);
      print("tamano datos "+datos_lineas.size());
      for (int i=0;i<datos_lineas.size();i++){
        if(datos_lineas.get(i).pos){
          if(posicionBolita2[0]<datos_lineas.get(i).x1 & posicionBolita2[0]>datos_lineas.get(i).x2){
            if(abs(posicionBolita2[1]-datos_lineas.get(i).y1)<=sensibilidad){
              posx2 = tam/2;
              posy2 = tam/2;
              }  
            }
        }
        else{
          if(posicionBolita2[1]<datos_lineas.get(i).y2 & posicionBolita2[1]>datos_lineas.get(i).y1){
            if(abs(posicionBolita2[0]-datos_lineas.get(i).x1)<=sensibilidad){
              posx2 = tam/2;
              posy2 = tam/2;
            }  
          }
        }
        if(abs(posicionBolita2[0]-posicion_trofeo)<tam/2 - 5 & abs(posicionBolita2[1]- (height - tam/2))<tam/2 - 5){
          background(0);
          fill(255);
          textSize(128);
          text("GANASTE 2", width/10, height/2-30);
          noLoop();
        }
      }
      //boolean gano2=colision(x2,y2,posx2,posy2,posicionBolita2,bolita2,false);
     // println(abs(posicionBolita[1]- (height - tam/2))<tam/2 - 5);
      
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
