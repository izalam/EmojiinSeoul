int numUsers = 35;


User[] users = new User[numUsers];

String[] userNames;
String[] userEmojis;
String[] userMessages;

void setup() {
  size(900, 900);
  //fullScreen();
  smooth();
  userNames = loadStrings(sketchPath()+"/data/userNames.txt");
  userEmojis = loadStrings(sketchPath()+"/data/userEmojis.txt");
  userMessages = loadStrings(sketchPath()+"/data/userMessages.txt");
  for (int i = 0; i < users.length; i++) {
    users[i] = new User(random(150, width - 150), 
              random(10, height),
              random(2, 30),
              i, users);
   String userName = userNames[i];
   String userEmoji = userEmojis[i];
   String userMessage = userMessages[i];
   users[i].setUser(userName, sketchPath()+"/data/emojiFiles/"+userEmoji, userMessage);
  }
}

void draw() {
  background(255);
  fill(255,0,0);

  for (int i = 0;  i < users.length; i++) {
    users[i].update();
    users[i].collide();
    users[i].display();
  }
}