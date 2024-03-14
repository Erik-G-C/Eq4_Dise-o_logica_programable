class Projectil{
  int x1, y1;
  float speedX, speedY;
  int radius;
  
  Projectil(int _x1, int _y1, float _speedX, float _speedY){
    x1 = _x1;
    y1 = _y1;
    speedX = _speedX;
    speedY = _speedY;
    radius = 5;
  }

  void update(){
    x1 += speedX;
    y1 += speedY;
  }
  
  void display(){
    fill(255);
    ellipse (x1, y1, radius*2, radius*2);
  }
  boolean isOffScreen() {
    return (x1 < 0 || x1 > width || y1 < 0 || y1 > height);
  }
}  
