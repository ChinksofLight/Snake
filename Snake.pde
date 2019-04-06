class Snake {
  int mx;
  int my;
  
  int forbidden_direction = 0;
  
  Snake next;
  
  Snake () {
  }
  
  void clone(Snake s) {
    update(s.mx, s.my);
    forbidden_direction = s.forbidden_direction;
    if (s.next != null) {
    next = new Snake();
    next.clone(s.next);
    }
  }
  
  void update (int x, int y) {
       if(next != null)
         next.update(mx, my);
       mx = x;
       my = y;
       if (mx == 16) mx = 0;
       if (mx == -1) mx = 15;
       if (my == 16) my = 0;
       if (my == -1) my = 15;
  
  }
  
  void draw() {
    fill(0);
    rect(mx * 50, my * 50, 45, 45);
    if(next != null)
    next.draw();
  }
  
  void grow () {
    if (next == null) {
      next = new Snake();
      next.update(mx, my);
    }
    else
      next.grow();
  }
  
 boolean move (int i) {
    if (forbidden_direction == i) return false;
    switch(i) {
      case 1:
          update(mx+1, my);
          forbidden_direction = 2;
          break;
      case 2:
          update(mx-1, my);
          forbidden_direction = 1;
          break;
      case 3:
          update(mx, my+1);
          forbidden_direction = 4;
          break;  
      case 4:
          update(mx, my-1);
          forbidden_direction = 3;
          break;          
          
    }
    
    return true;
  }
  
  boolean intersect () {
    Snake to_check = next;
    while(to_check != null) {
      if(to_check.mx == mx && to_check.my == my)
        return true;
      to_check = to_check.next;
    }
    return false;
  }
  boolean food(int x, int y) {
    if(mx == x && my == y) return true;
        Snake to_check = next;
    if(to_check != null) {
      return to_check.food(x ,y);
    }
    return false;
  }
}