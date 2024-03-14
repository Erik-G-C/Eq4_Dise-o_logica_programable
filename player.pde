class Player {
  int x,y;
  float xSpeed,ySpeed;
  float accel,deccel;
  float maxXspd,maxYspd;
  float xSave,ySave;
  int xRep,yRep;
  float gravity;
  float state;
  float stateRate;
  float stateShift;
  int charXShift;
  int charYShift;
  int pace;
  boolean lastMovedLeft; // Variable para rastrear la última dirección de movimiento
  //boolean aPressed, wPressed, dPressed;
  PImage stillRight; // Imagen de "still" cuando el jugador se mueve hacia la derecha
  PImage stillLeft; // Imagen de "still" cuando el jugador se mueve hacia la izquierda
  
  Player(int _x, int _y ) {
    x = _x;
    y = _y;
    xSpeed = 0;
    ySpeed = 0;
    accel = 0.5; //0.5
    deccel = 0.5;
    maxXspd = 2;
    maxYspd = 12;
    xSave = 0; //0
    ySave = 0; //0
    xRep = 0; //0
    yRep = 0; //0
    gravity = 0.3;
    stateRate = .1;
    stateShift = 2;
    charXShift = 22;
    charYShift = 105;
    pace = 2;
    lastMovedLeft = false; // Inicialmente no se ha movido a la izquierda
    //aPressed = false;
    //wPressed = false;
    //dPressed = false;  
    
  }
  
  
   boolean isCollidingWithEnemy(Enemy enemy) {
        // Calcula la distancia entre el jugador y el enemigo
        float distance = dist(x, y, enemy.x, enemy.y);
        // Si la distancia es menor que un cierto umbral (por ejemplo, el radio del jugador), retorna true
        return distance < 20 ;
    }
  
  void update() {
    
    if ( dPressed) {
      xSpeed += accel;
      if ( xSpeed > maxXspd ) {
        xSpeed = maxXspd;
      }
      state = state + stateRate;
            if (state >2) {
            state =  stateRate;
           }
      lastMovedLeft = false; // El jugador se está moviendo hacia la derecha
    }
    else if ( aPressed ) {
      xSpeed -= accel;
      if ( xSpeed < -maxXspd ) {
        xSpeed = -maxXspd;
      }
      state = state - stateRate;
            if (state <-2) {
            state = - stateRate;
           }
      lastMovedLeft = true; // El jugador se está moviendo hacia la izquierda
    }
    else { //neither right or left pressed, decelerate
      state = 0;
      if ( xSpeed > 0 ) {
        xSpeed -= deccel;
        if ( xSpeed < 0 ) {
           xSpeed = 0;
        }
      }
      if ( xSpeed < 0 ) {
        xSpeed += deccel;
        if ( xSpeed > 0 ) {
           xSpeed = 0;
        }
      }
    }
     
    if (  wPressed ) {
      if ( !place_free(x,y+pace) && !place_free(x+charXShift,y+pace)) {
        ySpeed = -4.3;
      }
    }
    ySpeed += gravity;
    
    int signX = (xSpeed<0) ? -pace : pace;
    int signY = (ySpeed<0) ? -pace : pace;
        
    xRep += floor(abs(xSpeed));
    yRep += floor(abs(ySpeed));
                 
    for ( ; yRep > 0; yRep-- ) {
      if ( place_free(x,y+signY) && place_free(x+charXShift,y+signY)) {
        y += signY;
      }
      else {
        ySpeed = 0;
      }
    }
    
    for ( ; xRep > 0; xRep-- ) {
      if ( place_free(x+signX,y-charYShift) && place_free(x+signX,y) ) {
        x += signX;
      }
      else {
        xSpeed = 0;
      }
    }
  }
  
  void display() {
   if(xSpeed ==0){
    if (lastMovedLeft) {
      // Imagen de "still" cuando el jugador se movió hacia la izquierda
       PImage stillLeft;
      stillLeft = loadImage("sl_left.png");
      image(stillLeft, x, y - charYShift); 
    } else {
      // Imagen de "still" cuando el jugador se movió hacia la derecha
      PImage stillRight;
      stillRight = loadImage("sl.png");
      image(stillRight, x, y - charYShift); 
    }
   }  
    //LEFTA
    if (state <0 && state >=-1){
     PImage leftB;
     leftB = loadImage("la.png");//loadImage("lefta.png");
     image(leftB, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB
    else if (state <-1 && state >=-2){ 
     PImage leftB;
     leftB = loadImage("leftb.png");//loadImage("leftb.png");
     image(leftB, x, y-charYShift);
    }// END LEFTB
    
    //RIGHTA
    else if (state >0 && state <=1){
      PImage rightA;
      rightA = loadImage("ra.png");//loadImage("righta.png");
      image(rightA, x,y-charYShift);
    }// END RIGHTA
    
    //RIGHTB
    else if (state >1 && state <=2){
      PImage rightB;
      rightB = loadImage("rightb.png");//loadImage("rightb.png");
      image(rightB, x, y-charYShift);
    }// END RIGHTB
  }
}
