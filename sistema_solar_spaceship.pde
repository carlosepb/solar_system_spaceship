import gifAnimation.*;

float ang, angS, angM, angV, angT, angMA, angJ, angL;
PImage fondo, solSkin, mercurioSkin, venusSkin, tierraSkin, marteSkin, jupiterSkin, lunaSkin, ioSkin, europaSkin;
boolean up, down, left, right, w, s, naveOn;
float moveX, moveY, moveZ;
float velX, velY, velZ, velInc;
PShape sol, mercurio, venus, tierra, marte, jupiter, io, luna, europa;

//GifMaker fileGIF;

void setup()
{
  naveOn=false;
  size(1400, 800, P3D);
  
  camera();
  stroke(100);
  
  velInc=1.5;
  
  ang=0;
  angL=0;
  
  solSkin =loadImage("images/sol.JPG");
  mercurioSkin =loadImage("images/mercurio.JPG");
  venusSkin =loadImage("images/venus.JPG");
  tierraSkin =loadImage("images/la_tierra.JPG");
  marteSkin =loadImage("images/marte.JPG");
  jupiterSkin =loadImage("images/jupiter.JPG");
  
  lunaSkin =loadImage("images/la_luna.JPG");
  ioSkin =loadImage("images/io.JPG");
  europaSkin =loadImage("images/europa.JPG");
  
  fondo=loadImage("images/background2.jpg");
  
  beginShape();  
  
  sol = createShape(SPHERE, 75);
  sol.setStroke(255);
  sol.setTexture(solSkin); 
  mercurio = createShape(SPHERE, 20);
  mercurio.setStroke(255);
  mercurio.setTexture(mercurioSkin); 
  venus = createShape(SPHERE, 30);
  venus.setStroke(255);
  venus.setTexture(venusSkin); 
  tierra = createShape(SPHERE, 28);
  tierra.setStroke(255);
  tierra.setTexture(tierraSkin); 
  marte = createShape(SPHERE, 24);
  marte.setStroke(255);
  marte.setTexture(marteSkin); 
  jupiter = createShape(SPHERE, 60);
  jupiter.setStroke(255);
  jupiter.setTexture(jupiterSkin);
  
  luna = createShape(SPHERE, 7);
  luna.setStroke(255);
  luna.setTexture(lunaSkin);
  io = createShape(SPHERE, 10);
  io.setStroke(255);
  io.setTexture(ioSkin);
  europa = createShape(SPHERE, 10);
  europa.setStroke(255);
  europa.setTexture(europaSkin);
  
  endShape();
  //fileGIF= new GifMaker(this,"animation.gif");
  //fileGIF.setRepeat(0);
  
  fill(255);
}

void draw()
{  
  background(0);
  if(naveOn){
    camera(width/2.0-moveX, height/2.0-moveY, moveZ+800, width/2.0-moveX, height/2.0-moveY, 0, 0, 1, 0);

    if(up==true && moveY<height/2.0) {
      velY+=testIncrement(velInc,velY);
    }
    if(down==true && moveY>-height/2.0){
      velY+=testIncrement(-velInc,velY);
    }
    if(left==true && moveX<width/2.0) {
      velX+=testIncrement(velInc,velX);
    } 
    if(right==true && moveX>-width/2.0) {
      velX+=testIncrement(-velInc,velX);  
    }
    if(s==true&& moveZ<300) {
      velZ+=testIncrement(velInc,velZ);
    }
    if(w==true && moveZ>-500) {
      velZ+=testIncrement(-velInc,velZ);
    } 
  }else{
    
    camera(width/2.0, height/2.0, moveZ+1000, width/2.0, height/2.0, 0, 0, 1, 0);
    
    pushMatrix();
    textSize(25);
    text("CONTROLES", 20, 20);
    text("Entrar en modo nave y salir -> Tecla enter", 20, 50);
    text("Moverse Arriba,abajo,izquierda y derecha -> Flechas teclado", 20, 80);
    text("Moverse Adelante y atrás -> w y s", 20, 110);
    translate(width/2.0, height/2.0, 700);
    box(20);
    popMatrix();
  }
  updateAngles();
  translate(width/2, height/2, 0);
  
  //El sol
  pushMatrix();
  rotateY(radians(angS));
  textSize(25);
  shape(sol);
  rotateY(radians(-angS));
  text("El SOL", -30, -90);
  popMatrix();
     
  //Mercurio
  pushMatrix();
  textSize(15); 
  rotateY(radians(angM));
  translate(150,0,0);
  rotateY(radians(angM));
  shape(mercurio);
  rotateY(radians(angM*(-2)));
  text("MERCURIO", -35, -35);
  popMatrix();
   
  //Venus
  pushMatrix();
  rotateY(radians(angV));
  translate(250,0,0);
  rotateY(radians(angV));
  shape(venus);
  rotateY(radians(angV*(-2)));
  text("VENUS", -25, -35);
  popMatrix();
  
  //La tierra
  pushMatrix();
  rotateY(radians(angT));
  translate(350,0,0);
  rotateY(radians(angT));
  shape(tierra);
  rotateY(radians(angT*(-2)));
  text("LA TIERRA", -35, -35);
  
  //Luna (Tierra)
  rotateZ(radians(angL));
  translate(45,0,0);
  shape(luna);
  popMatrix();
  
  //Marte
  pushMatrix();
  rotateY(radians(angMA));
  translate(450,0,0);
  rotateY(radians(angMA));
  shape(marte);
  rotateY(radians(angMA*(-2)));
  text("MARTE", -25, -35);
  popMatrix();
  
  //Jupiter
  pushMatrix();
  rotateY(radians(angJ));
  translate(700,0,0);
  rotateY(radians(angJ));
  shape(jupiter);
  rotateY(radians(angJ*(-2)));
  text("JUPITER", -25, -70);
  
  //IO
  rotateZ(radians(angL));
  translate(70,0,0);
  shape(io);
  
  //Europa
  translate(-140,70,0);
  shape(europa);
  popMatrix();
  
  reduceVelocity();
  
  moveX+=velX;
  moveY+=velY;
  moveZ+=velZ;
  
  //fileGIF.addFrame();
}

float testIncrement(float inc, float vel){
  if(inc>0 && vel<15){  
    return inc;
  }else if(inc<0 && vel>-15){
    return inc;
  }else{
    return 0;
  }
}

void reduceVelocity(){
  if(velX>0){
    velX-=0.5;
  }else if(velX<0){
    velX+=0.5;
  }
  if(velY>0){
    velY-=0.5;
  }else if(velY<0){
    velY+=0.5;
  }
  if(velZ>0){
    velZ-=0.5;
  }else if(velZ<0){
    velZ+=0.5;
  }
}

void updateAngles(){
  ang=updateAngle(ang, 0.0008);
  angS=updateAngle(angS, 0.5);
  angM=updateAngle(angM, 0.6);
  angV=updateAngle(angV, 0.45);
  angT=updateAngle(angT, 0.3);
  angMA=updateAngle(angMA, 0.35);
  angJ=updateAngle(angJ, 0.25);
  angL=updateAngle(angL, 1);
}

float updateAngle(float currentAngle, float increment){
  if (currentAngle>360){
    currentAngle=0;
  } else{
    currentAngle+=increment;
  }
  return currentAngle;
}

void keyPressed()
{
  if (keyCode == UP)
  {
    up = true;
  }
  if (keyCode == DOWN)
  {
    down = true;
  }
  if (keyCode == LEFT)
  {
    left=true;
  }
  if (keyCode == RIGHT)
  {
    right=true;
  }
  if(key == 'w' || key == 'W'){
    w=true;
  }
  if(key == 's' || key == 'S'){
    s=true;
  }
}

void keyReleased()
{
  if (keyCode == UP)
  {
    up = false;
  }
  if (keyCode==DOWN)
  {
    down = false;
  }
  if (keyCode == LEFT)
  {
    left=false;
  }
  if (keyCode == RIGHT)
  {
    right=false;
  }
  if(key == 'w' || key == 'W'){
    w=false;
  }
  if(key == 's' || key == 'S'){    
    s=false;
  }
  if(keyCode==ENTER){
    moveX=0;
    moveY=0;
    moveZ=0;
    naveOn=!naveOn;
  }
}

void mousePressed ( ) {
  //fileGIF.finish();
}
