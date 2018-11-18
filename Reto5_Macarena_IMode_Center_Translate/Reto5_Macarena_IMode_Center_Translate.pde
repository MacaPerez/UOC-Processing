import controlP5.*;

/*
* Variables
*/

import controlP5.*; //
ControlP5 controls; //

int caso;
int i;
float scaleBig;
int scaleLit;

// Time variables
int time_now;
int time_old;
int time_delta;
float sec;

 //Botón tirar
boolean click;

//Bird-Ball varibales
float ball_x; //
float ball_y; 
int ball_radio;
float ball_x_old;
float ball_x_speed;
float ball_x_speed_old;
float ball_x_acceleration;

int velocidad;

//Imágenes
PImage canon; // Icon made by [https://www.freepik.es/] from www.flaticon.com 
PImage fondo; // Image designed by Freepik (info: http://www.freepik.com/terms_of_use)
PImage bird; // Icon made by [https://pixelbuddha.net/] from www.flaticon.com 
PImage dispara;
PImage dispara2;
PImage nuevo;
PImage nuevo2;
int canon_x;
int canon_y;
color dark;
/*
* Inicialización de las variables
*/

void setup () {
  
 fondo = loadImage ("fondo.jpg");
 bird = loadImage ("bird.png");
 canon = loadImage ("canon.png");
 dispara = loadImage ("dispara.png");
 dispara2 = loadImage ("dispara2.png");
 nuevo = loadImage ("nuevo.png");
 nuevo2 = loadImage ("nuevo2.png");
 
 dark = color(29, 57, 81);
 
 size (900, 800);
 frameRate (25);
 
 controls = new ControlP5(this);
 
   //Botones disparar/nuevo disparo
  
  controls.addButton ("Dispara")
          .setValue(0)
          .setPosition (((width/2)+ 100),220)
          .setSize(100,100)
          .activateBy(Button.RELEASE)
          .setImages(dispara, dispara2, dispara2) 
          ;
          
          
  //slider       
  controls = new ControlP5(this);
  controls.addSlider("velocidad")
     .setPosition(((width/2)-300),250)
     .setSize(300,50)
     .setRange(0,100)
     .setNumberOfTickMarks(10)
     ;
     
 controls.getController("velocidad").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
 controls.getController("velocidad").getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
     
 click=false; 
 velocidad=0;
  
 // Time init
 time_old = 0;
 time_now = 0;
 time_delta = 0;
 
 time_now = millis ();
 time_delta = time_now - time_old; // La usaremos hacer el cáculo de la nueva posición
 time_old = time_now;
 sec = time_delta /1000.0;
 
 // Ball init
 ball_x = 238.0;
 ball_y = (height / 2) + 200; 
 ball_radio = 90;
 ball_x_old = 238.0; 
 ball_x_speed = 0.0;
 ball_x_speed_old = velocidad/1.0;
 ball_x_acceleration = 9.8; // La aceleración de la tierra
 
 //Canon position
 canon_x = 10;
 canon_y = (height/2) + 150;
 
 //Incremento
 i = 0;
 
 //Escalado
 scaleBig = 1.3;
 scaleLit = 1;
 
 //Casos
 caso = 0;
}

void draw () {
      drawFondo();
      drawCanon();
    
  switch (caso) {
      case 0: // Pinta cañón y pájaro quietos
        drawFondo();
        drawCanon();
        break;
        
     case 1: // Pulsa "Dispara", el cañón retrocede y empieza el lanzamiento a la velocidad seleccionada
         if (ball_y< width && ball_x < width +120 && click == true){ //Mientras no ha llegado al final de la pantalla, el pájaro se mueve   
         
          drawBird ();
          moveBird ();
          canonPum ();
          }

          if (ball_x >= width +90 ) { //Cuando llega al final de la pantalla, resetea "click", las posiciones de pájaro y cañón
          click = false; //Click pasa a falso
          ball_x = 238.0; //Reinicio las posiciones del pájaro
          ball_y = (height / 2) + 200;
          ball_x_old = 238.0;
          canon_x = 10; //Reinicio la posición del cañón
          delay(500); //Esperar 0.5 segundos.
          }
        break;   
  }
}


// Pinto fondo
void drawFondo(){
  image (fondo, 0, 0);
}

//Pinto Cañón
void drawCanon (){
  image (canon, canon_x, canon_y);
  
}
//Cambio posición del cañón durante el disparo
void canonPum (){
  while (canon_x>=5) {canon_x = canon_x -5; }
}

//Pinto Ball-bird

void drawBird () {
    imageMode (CENTER);
    
    if ((i % 2 ) != 0){ 
      pushMatrix();
      translate (ball_x, ball_y); 
      scale (scaleBig);
      println ("scaleBig");
      image (bird, 0, 0, ball_radio, ball_radio);
      popMatrix();
    }else{
      pushMatrix();
      translate (ball_x, ball_y); 
      scale(scaleLit);
      println ("scaleLit");
      image (bird, 0, 0, ball_radio, ball_radio);
      popMatrix(); 
} 
i ++;
imageMode (CORNER);
}


//Desplaza Ball-bird
void moveBird () {
   // Desplazamiento
      ball_x_speed = ball_x_speed_old + (ball_x_acceleration * sec);
      ball_x = ball_x_old + (velocidad * sec) +
      ( (ball_x_acceleration * sec * sec) / 2.0 );
      ball_y = ball_y * (HALF_PI/1.6);
  //Reseteo variables
      ball_x_old = ball_x;
      ball_x_speed_old = ball_x_speed; 
      
}

//Dispara
public void Dispara(int theValue){
    click=true;
    caso = 1;
}

//Selecciona la velocidad del disparo
public void Velocidad(int value){
  velocidad = value;  
}

void slider(float theColor) {
  dark = color(theColor);
  println("a slider event.setting background to "+theColor);
}
