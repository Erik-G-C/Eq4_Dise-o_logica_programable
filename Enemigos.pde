class Enemy {
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
  float prevState;
  PImage defeatImage;
  boolean hit;

  Enemy(int _x, int _y ) {
    x = _x;
    y= _y;
    xSpeed = 10;
    ySpeed = 10;
    accel = 0.5;
    deccel = 0.5;
    maxXspd = 2;
    maxYspd = 12;
    xSave = 1;
    ySave = 1;
    xRep = 0;
    yRep = 0;
    gravity = 0.3;
    stateRate = .1;
    stateShift = 2;
    charXShift = 22;
    charYShift = 105;
    pace = 2;
    prevState =0;
    defeatImage = loadImage("derrotado.png");
    hit = false;
  }
  
  boolean isHit(Projectil projectile) {

        float enemyCenterX = x + charXShift ;
        float enemyCenterY = y + charYShift ;

        // Coordenadas del proyectil
        float projectileX = projectile.x1;
        float projectileY = projectile.y1;
        // Distancia entre el centro del enemigo y la posición actual del proyectil
        float distance = dist(enemyCenterX, enemyCenterY, projectileX, projectileY);

        if (distance < 200) { // Cambia 20 por el valor que necesites según el tamaño del enemigo
            return true;
        } else {
            return false;
        }
    }
  
  
  
    void update2() {
    if(!hit){  
    x += xSpeed;
   // Incrementa la velocidad en la dirección X
    xSpeed -= accel;
    if (xSpeed < maxXspd) {
        xSpeed = maxXspd;
    }

    // Actualiza el estado
    state += stateRate;
    if (state > 2) {
        state = stateRate;
    } 

}
}
    
  
  void display2() {//DISPLAY///////////////
     
    //RIGHTA
    if (hit) { // Si el enemigo ha sido golpeado, muestra la imagen de derrotado
      image(defeatImage, x, y - charYShift);
    } else {
    if (state <1){
      image(rightA, x,y-charYShift);
    }// END RIGHTA
    
    //RIGHTB
    else if (state >1){
      image(rightB, x, y-charYShift);
    }// END RIGHTB
  
  }
} 
  
    void update1() {
    if(!hit){
      x += xSpeed;
   // Incrementa la velocidad en la dirección X
     xSpeed -= accel;
     if (xSpeed < -maxXspd) {
         xSpeed = -maxXspd;
     }

    // Actualiza el estado
    state += stateRate;
    if (state > 2) {
        state = stateRate;
    } 

 }
}
    
  void display1() {//DISPLAY///////////////
     if (hit) { // Si el enemigo ha sido golpeado, muestra la imagen de derrotado
      image(defeatImage, x, y - charYShift);
    } else {
     if (state <1){
     image(leftB, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB
    else if (state >1 ){     
     image(lb, x, y-charYShift);
    }// END LEFTB
    
    
    }// END RIGHTB
 } 
  void displayDefeat() {
    image(defeatImage, x, y - charYShift);
  }
  
//END CLASS///////////////////////


 // Método para comprobar si el enemigo ha desaparecido completamente de la pantalla
  boolean isOffScreen() {
    return x < -charXShift || x > width || y < -charYShift || y > height;
  }

}
