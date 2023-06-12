float cx = 0;      // circle position (set by mouse)
float cy = 0;
float movx = 0;
float movy = 0;
int sensibilidad = 20;

//bandera
boolean blockx = false;
boolean blocky = false;


void setup(){
  frameRate(120);
  size(500,500);
  background(0);
}

void draw(){
  background(0);
  noFill();
  stroke(255);
  strokeWeight(4);
  square(100,100,300);
  cx = mouseX;
  cy = mouseY;
  print("x: " + cx + " ");
  print("y: " + cy + " ");
  //condicionales
  if(!blockx){
    movx = cx;   
  }
  if(!blocky){
    movy = cy;   
  }
  println();
  if(movx < 100 + sensibilidad || movx > 400 - sensibilidad){
    blockx = true;
    println("bloqueado");
  }
  if(cx > 100 + sensibilidad & cx < 400 - sensibilidad & blockx){
    blockx = false;
    println("desbloqueadox");
  }
    
  if(movy < 100 + sensibilidad || movy > 400 - sensibilidad){
    blocky = true;
    println("bloqueado");
  }
  if(cy > 100 +sensibilidad & cy < 400 - sensibilidad & blocky){
    blocky = false;
    println("desbloqueado");
  }
  
  
  fill(0,150,255, 150);
  noStroke();
  ellipse(movx,movy, 20,20);
}
