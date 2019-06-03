import java.awt.*;
import java.awt.event.*; // Imports events for buttons. 

float S = 8;
class Shooter {
  int x, y, sx, sy, size;

  Shooter(int a, int b, int s) {
    this.x = a;
    this.y = b;

    this.sx = s;  
    this.sy = s;

    this.size = 20;
  }

  void move() {
    //this.x += this.sx;
    //this.y += this.sy;

    if (this.x > 1200 - this.size) this.x = 1200 - this.size;
    else if (this.x < 0) this.x = 0;

    if (this.y > 800 - this.size) this.y = 800 - this.size;
    else if (this.y < 0) this.y = 0;
  }

  void moveRight() {
    this.x += sx;
  }
  
  void moveLeft() {
    this.x -= sx;
  }

  void moveUp() {
    this.y -= sy;
  }

  void moveDown() {
    this.y += sy;
  }


  void render() {

    fill(0, 0, 0);
    rect(this.x, this.y, this.size, this.size);
    if (mousePressed){
      bullets.add(new Shoot(this.x, this.y, mouseX, mouseY));
      }
    }
  }

  /*
  void keyPressed(KeyEvent e){
   int button = e.getKeyCode();
   if(button == KeyEvent.VK_UP)this.y -= 2;
   if(button == KeyEvent.VK_DOWN)this.y += 2;
   if(button == KeyEvent.VK_LEFT)this.x -= 2;
   if(button == KeyEvent.VK_RIGHT)this.x += 2;
   }
   */
   


Shooter shooter = new Shooter(100, 100, 3);

class Shoot {
  float x, y, sx, sy;

  Shoot(float x, float y, float x2, float y2) {
    this.x = x;
    this.y = y;


    float deltax = x2 - x;
    float deltay = y2 - y;

    float hypo = dist(x2, y2, x, y);

    this.sx = S * deltax / hypo;
    this.sy = S * deltay / hypo;
  }


  void process() {
    this.x += this.sx;
    this.y += this.sy;

    //this.sy += 0.1;

    stroke(0, 255, 0);
    line(this.x, this.y, this.x + this.sx, this.y + this.sy);
  }
}

ArrayList<Shoot> bullets = new ArrayList<Shoot>();

void setup() {
  size(1200, 800);
}


void draw() {
  fill(255);
  rect(0, 0, 1200, 800 );


  //shooter.keyPressed(KeyEvent);
  shooter.render();
  shooter.move();
  if (keyPressed) {
    if (key == 'd' || key == 'D') {
      shooter.moveRight();
    } 
    if (key == 'a' || key == 'A') {
      shooter.moveLeft();
    } 
    if (key == 'w' || key == 'W') {
      shooter.moveUp();
    } 
    if (key == 's' || key == 'S') {
      shooter.moveDown();
    }
  }

  
  for (int i = 0; i < bullets.size(); i++) bullets.get(i).process();
  
  
  
  for (int i = 0; i < bullets.size(); i++) {
    if (bullets.get(i).x < 0 || bullets.get(i).x > 1500 ||bullets.get(i).y < 0 || bullets.get(i).y > 1000) {
      bullets.remove(i);
      i--;
    }
  }
}

