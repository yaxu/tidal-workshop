class Thing {
  String word;
  color c;
  float rotation;
  float distance;
  int life; 
  int x;
  int y;
  int str;
  int age;

  Thing (String word, color c, float rotation, float distance, int life, int x, int y, int str) {
    println("new thing");
    this.word = word;
    this.c = c;
    this.rotation = rotation;
    this.distance = distance;
    this.life = life;
    this.x = x;
    this.y = y;
    this.str = str;
    age = 0;
  }

  boolean finished() {
    return(age > life);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    for (int i = 0; i < word.length(); ++i) {
      drawChar(word.charAt(i), this);
      translate(distance, 0);
      rotate(radians(diez/random(10, 30)));
      strokeWeight(str);
      //rotate(rotation);
    }
    diez++;
    popMatrix();
    age = age + 1;
  }
}; 