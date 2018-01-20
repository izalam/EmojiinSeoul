class User {
  float x;
  float y;
  float w;
  User[] others;
  float vx =  0.01;
  float vy = 0.01;
  int id;

  String userEmoji;
  String userName;
  String userMessage;

  PImage emoji;
  boolean showMessage = true;
  boolean bcollide = true;
  User(float _x, float _y, float _w, int idin, User[] oin) {
    x = _x;
    y = _y;
    w = _w;
    //c = _c;
    id = idin;
    others = oin;
  }

  void setUser(String userName, String userEmoji, String userMessage) {
    this.userName = userName;
    this.userEmoji = userEmoji;
    this.userMessage = userMessage;
    emoji = loadImage(this.userEmoji);
  }

  void collide() {
    
    for (int i = id + 1; i < numUsers; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].w/2 + w/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x);
        float ay = (targetY - others[i].y);
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }
  }

  void update() {
    //이모지 동작이 true일 때만 실행
    if(bcollide==true){
      x += vx;
      y += vy;
      //println(vx);
      if (x > width - w/2 || x < 0 + w/2) { 
        vx = vx * -1;
        if (vx > 5.0 || vx < -5.0) {
          vx *= 0.001;
        }
      }
  
      if (y > height - w/2 || y < 0 + w/2) {
        vy = vy * -1;
        if (vy > 5.0 || vy < -5.0) {
          vy *= 0.001;
        }
      }
    }
  }

  void display() {
    image(emoji, x, y, emoji.width, emoji.height);
    fill(0, 0, 0);
    text(userName, x, y +10+ emoji.height);
    toggleMessage();
    if (!showMessage) {
      noStroke();
      fill(50,100,255,100);
      rect(x, y, 120, 30 - emoji.height);
      fill(255);
      textAlign(LEFT);
      text(userMessage, x+5, y-5);
    }
    if(mousePressed && mouseButton ==RIGHT){
      stopEmoji();
    }
    
  }

  void toggleMessage() {
    if (mousePressed && mouseButton == LEFT) {
      float d = dist(mouseX, mouseY, x, y);
      if (d < emoji.width) {
        showMessage = !showMessage;
        //println(id, showMessage);
      }
    }
  }
  
  // 이모지 동작 멈추는 부분
  void stopEmoji(){
   bcollide = !bcollide;
   println(bcollide);
  }
}