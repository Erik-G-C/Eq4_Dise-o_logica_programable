import processing.serial.*;

Serial port; // Declaración del objeto Serial
  int val;

final int WIDTH = 34;// 34 
final int HEIGHT = 32; // 32
final int MAX_ENEMIES_HORDA1 = 30; 
final int MAX_ENEMIES_HORDA2 = 30;
final int MAX_ENEMIES_HORDA3 = 100; 



int[][] level = new int[HEIGHT][WIDTH];
ArrayList<Projectil> projectiles;
ArrayList<Enemy> enemies;
ArrayList<Enemy> enemies2;
ArrayList<Enemy> enemies3;
ArrayList<Enemy> enemies4;


Player p1;

boolean dPressed = false, aPressed = false,  wPressed= false;
PImage bg, bg2, victoria;
int y;
PImage leftB, lb, rightA, ra, rightB, rb;
int Horda = 1;
int enemiesSpawnedHorda1 = 0;
int enemiesSpawnedHorda2 = 0;
int enemiesSpawnedHorda3 = 0;
int enemigosEliminados = 0;
int ENEMIES_TO_WIN = 100;
 
 

 //SETUP/////////////////////////////
void setup() { 
  size(1200, 700);
  noStroke(); 
  frameRate(150);  // Ejecutar 10 cuadros por segundo
  // Abrir el puerto al que está conectada la placa y usar la misma velocidad (9600 bps)
  port = new Serial(this, "COM13", 115200);
  projectiles = new ArrayList<Projectil>();
  enemies = new ArrayList<Enemy>();
  enemies2 = new ArrayList<Enemy>();
  enemies3 = new ArrayList<Enemy>();
  enemies4 = new ArrayList<Enemy>();
  //enemy1 = new Enemy(WIDTH*10, HEIGHT*10);
  bg = loadImage("background_editado.jpg");
  bg2 = loadImage("game_over.png");
  victoria = loadImage("victoria.PNG");
  p1 = new Player(WIDTH*10,HEIGHT*10);
  leftB = loadImage("la(1).png");
  lb = loadImage("lb(1).png");
  rightA = loadImage("ra(1).png");
  rightB = loadImage("rb(1).png");


}

//END SETUP////////////////////////// 
int lastSpawnTimeHorda1 = 0;
int spawnDelayHorda1 = 4500; 
int lastSpawnTimeHorda2 = 0;
int spawnDelayHorda2 = 4000; 
int lastSpawnTimeHorda3 = 0;
int spawnDelayHorda3 = 1000000;
 
//DRAW///////////////////////////////
void draw() {
  
  
  background(bg);
  stroke(226, 204, 0);
  p1.update();
  p1.display();
  textSize(24); // Establece el tamaño del texto
  fill(255); // Establece el color del texto en blanco
  text("Enemigos eliminados: 100 / " + enemigosEliminados, 40, 40 );
    if (0 < port.available()) {  // If data is available to read,
    val = port.read();   // read it and store it in val
    }
    switch (val) {
      case 68:
      dPressed = true; 
      lastKeyPressedRight = true;
      lastKeyPressedLeft = false;
      break;
      case 65:
      aPressed = true; 
      lastKeyPressedLeft = true;
      lastKeyPressedRight = false;
      break;
      case 87:
       wPressed = true; 
      break;
      case 83: // Cuando se presiona la tecla 's'
      int currentTime = millis();  
      // Verifica si ha pasado el tiempo suficiente desde el último disparo
      if (currentTime - lastShotTime > shotDelay) {
       float angle =0;
        if(p1.xSpeed == 0){
          if (lastKeyPressedLeft ) {
            angle= PI;        
          }
          else if(lastKeyPressedRight ){
            angle =0;
          }
        }
        else if (p1.xSpeed >=0){
          angle =0;
        }
        else{
          angle = PI;
        }
    
        float speedX = cos(angle) * 10; // Ajusta la velocidad del proyectil según tus necesidades
        float speedY = sin(angle) * 10;
        projectiles.add(new Projectil(p1.x + p1.charXShift/2 + 25, p1.y + p1.charYShift/2 - 110, speedX, speedY )); 
        lastShotTime = currentTime;
      }
      break;
      default: dPressed = false; aPressed = false; wPressed = false; 
    
  }
  
 
  
   
   if (enemigosEliminados >= ENEMIES_TO_WIN) {
    // Dibuja el mensaje de victoria
    image(victoria, width / 2 - victoria.width / 2, height / 2 - victoria.height / 2);
    noLoop(); // Detiene el bucle de draw, deteniendo el juego
    return; // Termina la función draw para evitar que se siga dibujando el juego
  }
  
  
   for (Enemy enemy : enemies) {
    if (p1.isCollidingWithEnemy(enemy)) {
      // Dibuja la imagen del game over
      image(bg2, width / 2 - bg2.width / 2, height / 2 - bg2.height / 2);
      noLoop(); // Detiene el bucle de draw, deteniendo el juego
      return; // Termina la función draw para evitar que se siga dibujando el juego
    }
  }
  
  
  
    for (Enemy enemy : enemies2) {
    if (p1.isCollidingWithEnemy(enemy)) {
      // Dibuja la imagen del game over
      image(bg2, width / 2 - bg2.width / 2, height / 2 - bg2.height / 2);
      noLoop(); // Detiene el bucle de draw, deteniendo el juego
      return; // Termina la función draw para evitar que se siga dibujando el juego
    }
  }
  
  
  for (Enemy enemy : enemies3) {
    if (p1.isCollidingWithEnemy(enemy)) {
      // Dibuja la imagen del game over
      image(bg2, width / 2 - bg2.width / 2, height / 2 - bg2.height / 2);
      noLoop(); // Detiene el bucle de draw, deteniendo el juego
      return; // Termina la función draw para evitar que se siga dibujando el juego
    }
  }
  
  
  for (Enemy enemy : enemies4) {
    if (p1.isCollidingWithEnemy(enemy)) {
      // Dibuja la imagen del game over
      image(bg2, width / 2 - bg2.width / 2, height / 2 - bg2.height / 2);
      noLoop(); // Detiene el bucle de draw, deteniendo el juego
      return; // Termina la función draw para evitar que se siga dibujando el juego
    }
  }





  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectil projectile = projectiles.get(i);
    projectile.update();
    projectile.display();
    if (projectile.isOffScreen()) {
      projectiles.remove(i); // Elimina el proyectil si está fuera de la pantalla
    }

    // Verifica colisiones con los enemigos
    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies.get(j);
      if (enemy.isHit(projectile)) {
        // Elimina el proyectil y el enemigo
        projectiles.remove(i);
        enemies.remove(j);
        enemigosEliminados++;
        // Puedes agregar cualquier otra lógica aquí, como aumentar la puntuación, etc.
        break; // Rompe el bucle interno, ya que no hay necesidad de verificar más colisiones para este proyectil
      }
    }
    
    for (int j = enemies2.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies2.get(j);
      if (enemy.isHit(projectile)) {
        // Elimina el proyectil y el enemigo
        projectiles.remove(i);
        enemies2.remove(j);
        enemigosEliminados++;
        // Puedes agregar cualquier otra lógica aquí, como aumentar la puntuación, etc.
        break; // Rompe el bucle interno, ya que no hay necesidad de verificar más colisiones para este proyectil
      }
    }
    
    for (int j = enemies3.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies3.get(j);
      if (enemy.isHit(projectile)) {
        // Elimina el proyectil y el enemigo
        projectiles.remove(i);
        enemies3.remove(j);
        enemigosEliminados++;
        // Puedes agregar cualquier otra lógica aquí, como aumentar la puntuación, etc.
        break; // Rompe el bucle interno, ya que no hay necesidad de verificar más colisiones para este proyectil
      }
    }
    
    
    for (int j = enemies4.size() - 1; j >= 0; j--) {
      Enemy enemy = enemies4.get(j);
      if (enemy.isHit(projectile)) {
        // Elimina el proyectil y el enemigo
        projectiles.remove(i);
        enemies4.remove(j);
        enemigosEliminados++;
        // Puedes agregar cualquier otra lógica aquí, como aumentar la puntuación, etc.
        break; // Rompe el bucle interno, ya que no hay necesidad de verificar más colisiones para este proyectil
      }
    }
    
  }
  
   if(Horda == 1){ 
     int currentTimeHorda1 = millis(); 
      if (currentTimeHorda1 - lastSpawnTimeHorda1 > spawnDelayHorda1 ) {
          enemies.add(new Enemy(1200, 610));
          lastSpawnTimeHorda1 = currentTimeHorda1;
          spawnDelayHorda1 -= 80;
           enemiesSpawnedHorda1++;
        if ( enemiesSpawnedHorda1 >= MAX_ENEMIES_HORDA1){
          Horda =2;     
      }
    }
   }
  
  
  
  
  if(Horda ==2){   
    int currentTimeHorda2 = millis();
    if (currentTimeHorda2 - lastSpawnTimeHorda2 > spawnDelayHorda2 && enemiesSpawnedHorda2 < MAX_ENEMIES_HORDA2) {
        enemies2.add(new Enemy(-200, 610));
        lastSpawnTimeHorda2 = currentTimeHorda2;
        spawnDelayHorda2 -= 60;
        if (spawnDelayHorda2 <0 ){
          Horda =3;
        }
    }
  }
  
  if(Horda ==3){   
    int currentTimeHorda3 = millis();
    if (currentTimeHorda3 - lastSpawnTimeHorda3 > spawnDelayHorda3 && enemiesSpawnedHorda3 < MAX_ENEMIES_HORDA3) {
        enemies3.add(new Enemy(-200, 610));
        enemies4.add(new Enemy(1200, 610));
        lastSpawnTimeHorda3 = currentTimeHorda3;
        spawnDelayHorda3 -= 300;
        if (spawnDelayHorda3 <0 ){
          spawnDelayHorda3 = 6000;
        }
    }
  }
  
  
  

    for (Enemy enemy : enemies) {
        enemy.update1();
        enemy.display1();
        
        
    }
    for (Enemy enemy : enemies2) {
        enemy.update2();
        enemy.display2();   
        
        
     }
     
     
      for (Enemy enemy : enemies4) {
        enemy.update1();
        enemy.display1();
        
        
    }
    for (Enemy enemy : enemies3) {
        enemy.update2();
        enemy.display2();   
        
        
       
     }
     
 
    
  
  for (int i = projectiles.size() -1; i>= 0; i--){
    Projectil projectil = projectiles.get(i);
    projectil.update();
    projectil.display();     
    if(projectil.x1 > width || projectil.x1 <0 ){
      projectiles.remove(i);
  }
} 
   
}
//END DRAW///////////////////////////
 
 boolean place_free(int xx,int yy) {
   xx = int(floor(xx));
   yy = int(floor(yy));
  if (yy < height-height/8) {
      return true;
  }
  return false;
}
 
// Variables para rastrear la última tecla presionada
boolean lastKeyPressedRight = false;
boolean lastKeyPressedLeft = false;
// Declara una variable para controlar el tiempo entre disparos
int lastShotTime = 0;
int shotDelay = 1000;


void keyReleased() {
  switch(val) {  
    case 68: 
      dPressed = false;
      lastKeyPressedRight = false;
      break;
    case 65: 
      aPressed = false; 
      lastKeyPressedLeft = false;
      break;
    case 87: 
      wPressed= false; 
      break;
  }
}
