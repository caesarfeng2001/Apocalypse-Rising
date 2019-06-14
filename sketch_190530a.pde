float S = 8;

int mapWidth = 24;
int mapHeight = 16;

String stage = "MENU";
String characters[] = new String[4];

int[][] map = new int[mapWidth][mapHeight];
int Zombies[] = new int[10];

int bw = 150;
int bh = 50;
int b1x = 525;
int b1y = 650;
int b2x = 525;
int b2y = 600;



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
    stroke(255, 0, 0);
    line(this.x, this.y, this.x + this.sx, this.y + this.sy);
  }
}




class Zombie {
  int x, y, size;

  Zombie(int a, int b) {
    this.x = a;
    this.y = b;
    this.size = 30;
  }

  void process() {
    if (this.x < shooter.x) this.x += random(2);
    else if (this.x > shooter.x) this.x -= random(2);

    if (this.y < shooter.y) this.y += random(2);
    else if (this.y > shooter.y) this.y -= random(2);

    fill(0, 255, 0);
    rect(this.x, this.y, this.size, this.size);
  }
}


//Declaration of classes
Shooter shooter = new Shooter(100, 100, 3);

ArrayList<Zombie> zombies = new ArrayList<Zombie>();

ArrayList<Shoot> bullets = new ArrayList<Shoot>();


void setup() {
  size(1200, 800);
  frameRate(100);
}


void draw() {
  if (stage == "GAME") {
    noStroke();
    fill(0);
    rect(0, 0, 1200, 800 );

    stroke(100);
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        rect(i * 50, j * 50, 50, 50);
      }
    }

    // movement for shooter below
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

    if (keyPressed) {
      if (key == 'm'|| key == 'M') zombies.add(new Zombie(int(random(1200)), int(random(800)), shooter.x, shooter.y));
    }


    for (int i = 0; i < zombies.size(); i++) zombies.get(i).process(); // draw zombies

    for (int i = 0; i < bullets.size(); i++) bullets.get(i).process(); // draw the bullets



    // remove bullets once they hit the edge of the screen or hit a zombie
    for (int i = 0; i < bullets.size(); i++) {
      if (bullets.get(i).x < 0 || bullets.get(i).x > 1500 ||bullets.get(i).y < 0 || bullets.get(i).y > 1000) {
        bullets.remove(i);
        i--;
      }/*
for (int j = 0; j < zombies.size(); j++) {
       if (bullets.get(i).x == zombies.get(j).x || bullets.get(i).y == zombies.get(j).y) {
       bullets.remove(i);
       zombies.remove(j);
       i--;
       j--;
       }
       }
       */
    }
  }
  if (stage == "MENU") Menu();
  if (stage == "INSTRUCTIONS") Instructions();
}





void Menu() {


  fill(0);
  rect(0, 0, 1200, 800);

  fill(0, 255, 0);
  rect(b1x, b1y, bw, bh);

  fill(255);
  textSize(30);
  text("CONTINUE", b1x, b1y - 30);
  textSize(30);
  text("A Survival Game By Caesar Feng", 350, 200);

  fill(204, 0, 0);
  textSize(100);
  text("APOCALYPSE RISING", 120, 100);
}

void Instructions() {
  fill(0);
  rect(0, 0, 1200, 800);

  fill(204, 0, 0);
  textSize(100);
  text("INSTRUCTIONS", 250, 100);

  fill(255);
  textSize(30);
  text("Control character using W A S D keys, shoot zombies by mouseclicking.", 80, 200);
  text("Press m to spawn zombies.", 80, 250);
  text("Survive as long as possible...", 80, 300);
  textSize(40);
  text("BEGIN", b2x + 18, b2y - 30);

  fill(0, 255, 0);
  rect(b2x, b2y, bw, bh);
}



void mousePressed() {
  if (mouseX > b1x && mouseX < b1x + bw && mouseY > b1y && mouseY < b1y + bh && stage == "MENU") stage = "INSTRUCTIONS";
  if (mouseX > b2x && mouseX < b2x + bw && mouseY > b2y && mouseY < b2y + bh && stage == "INSTRUCTIONS") stage = "GAME";
}
