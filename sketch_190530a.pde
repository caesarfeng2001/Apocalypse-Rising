float S = 8;

int x = 12;

int y = 8;

String characters[] = new String[4];

int[][] map = new int[x][y];

int Zombies[] = new int[10];


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

    if (this.x > 1200 - this.size) this.x = 1200 - this.size;
    else if (this.x < 0) this.x = 0;

    if (this.y > 800 - this.size) this.y = 800 - this.size;
    else if (this.y < 0) this.y = 0;
  }
  void moveTopRight() {
    this.x += sx;
    this.y -= sy;
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

    fill(255);
    rect(this.x, this.y, this.size, this.size);
    if (mousePressed) {
      if (random(10) > 8) {
        bullets.add(new Shoot(this.x, this.y, mouseX, mouseY));
      }
    }
  }
}

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
    stroke(230,44,44);
    line(this.x, this.y, this.x + this.sx, this.y + this.sy);
  }
}

ArrayList<Shoot> bullets = new ArrayList<Shoot>();


class Zombies {
  int x, y, sx, sy, size;
  
  Zombies(int a, int b, int s){
    this.x = a;
    this.y = b;
    
    this.sx = s;
    this.sy = s;
    
    this.size = 30;
    
  }
  
}



void setup() {
  size(1200, 800);
  frameRate(100);
}


void draw() {
  noStroke();
  fill(0);
  rect(0, 0, 1200, 800 );
  
  stroke(255);
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      rect(i * 100, j * 100, 100, 100);
    }
  }
  


  // movement for shooter below
  shooter.render();
  shooter.move();
   if (keyPressed){
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


  for (int i = 0; i < bullets.size(); i++) bullets.get(i).process(); // draw the bullets

// remove bullets once they hit the edge of the screen
  for (int i = 0; i < bullets.size(); i++) {
    if (bullets.get(i).x < 0 || bullets.get(i).x > 1500 ||bullets.get(i).y < 0 || bullets.get(i).y > 1000) {
      bullets.remove(i);
      i--;
    }
  }
}


/*
void keyPressed(){
  
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
}

void keyReleased(){
  
  
}
*/
