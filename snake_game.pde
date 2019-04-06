int x_food, y_food;

int score = 0;

Snake sneaky;

void setup() {
  size(800, 800); // window size
  
  textSize(40);
 
  sneaky = new Snake();
  sneaky.update((int)random (0, 16), (int)random (0, 16));
  
  generate_food();
}

void draw() {
  background(255); // white background
  AI(sneaky, 9);
  
  if(sneaky.mx == x_food && sneaky.my == y_food) {
      sneaky.grow();
      while(sneaky.food(x_food, y_food)) {
        generate_food();
      }
      score++;
      
      println(score);
      
  }
  
  fill(255, 0, 0);
  rect(x_food * 50, y_food * 50, 50, 50);
  sneaky.draw();
  fill(255, 0, 0);
  text("score:"+score,0, 40);
}

int AI (Snake snake, int max) {
 
  int best = 5, dist = 1000;
  for (int i = 1; i <= 4; i++) {
    
    Snake virtual = new Snake ();
    virtual.clone(snake);
    
    if(virtual.move(i) && !virtual.intersect()) {
      
      int new_dist = abs(virtual.mx - x_food) + abs(virtual.my - y_food);
      if(max > 0 && new_dist > 0) new_dist += AI(virtual, max - 1);
      if(new_dist <= dist){
        best = i; 
        dist = new_dist;    
        }
    }
      
    }
  
  if(!snake.move(best))
  return 1000;
  return dist;
}

void generate_food() {
      x_food = (int)random(0, 16);
      y_food = (int)random(0, 16);
}