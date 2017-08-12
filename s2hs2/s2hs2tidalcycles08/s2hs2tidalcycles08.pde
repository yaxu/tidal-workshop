import oscP5.*;
import netP5.*;
import oscP5.*;
import netP5.*;
import processing.pdf.*;

OscP5 osc;

import ddf.minim.*;
Minim minim;
AudioInput in;

boolean record;
PFont f;
String words = "a";
int ml = words.length();
int palabras = 200;
int girar = 90;
float oll = 230;
float mapa = 1;
float momento = 30;
int t = 6;
int diez;
float caer = radians(diez*0.1);


PShape ya;
PShape yb;
PShape yc;
PShape yd;
PShape ye;
PShape yf;
PShape yg;
PShape yh;
PShape yi;
PShape yj;
PShape yk;
PShape yl;
PShape ym;
PShape yn;
PShape yo;
PShape yp;
PShape yq;
PShape yr;
PShape ys;
PShape yt;
PShape yu;
PShape yv;
PShape yw;
PShape yx;
PShape yy;
PShape yz;


ArrayList<Thing> things = new ArrayList();

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

void setup() {
  smooth();
  noCursor();
  frameRate(12);
  size(400, 400);
  //fullScreen();
  //size(displayWidth, displayHeight); 
  /////////////////////////////////////////////////////////////////////
  printArray(PFont.list());
  /////////////////////////////////////////////////////////////////////
  colorMode(RGB);
  /////////////////////////////////////////////////////////////////////
  osc = new OscP5(this, 8010);
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.STEREO, 1024);
  ya = loadShape("a.svg");
  yb = loadShape("b.svg");
  yc = loadShape("c.svg");
  yd = loadShape("d.svg");
  ye = loadShape("e.svg");
  yf = loadShape("f.svg");
  yg = loadShape("g.svg");
  yh = loadShape("h.svg");
  yi = loadShape("i.svg");
  yj = loadShape("j.svg");
  yk = loadShape("k.svg");
  yl = loadShape("l.svg");
  ym = loadShape("m.svg");
  yn = loadShape("n.svg");
  yo = loadShape("o.svg");
  yp = loadShape("p.svg");
  yq = loadShape("q.svg");
  yr = loadShape("r.svg");
  ys = loadShape("s.svg");
  yt = loadShape("t.svg");
  yu = loadShape("u.svg");
  yv = loadShape("v.svg");
  yw = loadShape("w.svg");
  yx = loadShape("x.svg");
  yy = loadShape("y.svg");
  yz = loadShape("z.svg");
}

void draw() {
  if (record) {
    beginRecord(PDF, "astr"+random(1000)+".pdf");
  }

  if ((keyPressed == true) && (key ==  '<')) {
    palabras = 200;
    noStroke();
    rectMode(CORNERS);
    fill(palabras, 0);
    //fill(lerpColor(#FF746C, #C9D2FF, random(1)), random(255));
    rect(0, 0, width, height);
  } else {
    noStroke();
    rectMode(CORNERS);
    //    fill(lerpColor(#000000, #4A00C4, random(1)), random(255));
    fill(palabras);
    rect(0, 0, width, height);
  }
  synchronized(things) {
    for (Thing thing : things) {
      thing.display();
    }
  }
  for (int i = things.size () - 1; i >= 0; i--) {
    Thing thing = things.get(i);
    if (thing.finished()) {
      print("remove");
      things.remove(i);
    }
  }
  if (record) {
    endRecord();
    record = false;
  }
  // Use a keypress so thousands of files aren't created
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      record = true;
    }
  }
}

void oscEvent(OscMessage m) {
  String word = m.get(0).stringValue();
  float r = m.get(1).floatValue();
  float g = m.get(2).floatValue();
  float b = m.get(3).floatValue();
  float rotation = m.get(4).floatValue();
  float distance = m.get(5).floatValue();
  int life = m.get(6).intValue();
  float x = m.get(7).floatValue();
  float y = m.get(8).floatValue();
  int str = m.get(9).intValue();

  Thing thing = new Thing(word, 
    color(r, g, b), 
    rotation, 
    distance, 
    life, 
    int(x*width), int(y*height), 
    str
    );
  synchronized(things) {
    things.add(thing);
  }
}

void keyReleased() {
  if (palabras == 200) {
    if (key == '1' || key == '1') {
      palabras = #FFC905;
    }
  }

  if (palabras == 200) {
    if (key == '2' || key == '2') {
      palabras = #FFA805;
    }
  }

  if (palabras == 200) {
    if (key == '3' || key == '3') {
      palabras = #FF8205;
    }
  }
  if (palabras == 200) {
    if (key == '4' || key == '4') {
      palabras = #FF5905;
    }
  }
  if (palabras == 200) {
    if (key == '5' || key == '5') {
      palabras = #FFAB03;
    }
  }
  if (palabras == 200) {
    if (key == '6' || key == '6') {
      palabras = #FF008D;
    }
  }
  if (palabras == 200) {
    if (key == '7' || key == '7') {
      palabras = #9800FF;
    }
  }
  // cambiar tamaño a la 'a'
  if (t == 6) {
    if (key == 'q' || key == 'Q') {
      t = 13;
    }
  }
  if (t == 13) {
    if (key == 'w' || key == 'W') {
      t = 23;
    }
  }  
  if (t == 23) {
    if (key == 'e' || key == 'E') {
      t = 43;
    }
  }  
  if (t == 43) {
    if (key == 'r' || key == 'R') {
      t = 53;
    }
  } 
  if (t == 53) {
    if (key == 't' || key == 'T') {
      t = 63;
    }
  }
  if (t == 63) {
    if (key == 'y' || key == 'Y') {
      t = 73;
    }
  }
  if (t == 73) {
    if (key == 'u' || key == 'U') {
      t = 83;
    }
  }
  if (t == 83) {
    if (key == 'i' || key == 'I') {
      t = 93;
    }
  }
  if (t == 93) {
    if (key == 'o' || key == 'O') {
      t = 203;
    }
  }
  if (t == 203) {
    if (key == 'p' || key == 'P') {
      t = 6;
    }
  }
}

void rama(float len ) {
  for (int o = 0; o < in.bufferSize() -1; o++) {
    mapa = (mapa+in.right.get(o)*10)*sin(radians(
      (in.bufferSize()/momento)*o));
  }
  recaer();
  ellipse(100, -10, mapa*len, mapa*len);
  translate(0, -len);
  float newLen = len * 0.5;
  if (newLen < 0.3) {
    return;
  } else {
    pushMatrix();
    rotate(radians(oll));
    rama(newLen);
    popMatrix();

    pushMatrix();
    rotate(radians(-oll));
    rama(newLen);
    popMatrix();
  }
}

void amar(float len ) {
  for (int o = 0; o < in.bufferSize() -1; o++) {
    mapa = (mapa+in.right.get(o)*10)*sin(radians(
      (in.bufferSize()/momento)*o));
  }
  recaer();
  triangle(30, 75*len, 58, 20*len, 86, 75*len);
  //ellipse(100, -10, mapa*len, mapa*len);
  translate(0, -len);
  float newLen = len * 0.5;
  if (newLen < 0.3) {
    return;
  } else {
    pushMatrix();
    rotate(radians(oll));
    amar(newLen);
    popMatrix();

    pushMatrix();
    rotate(radians(-oll));
    amar(newLen);
    popMatrix();
  }
}

void amarr(float len ) {
  for (int o = 100; o < in.bufferSize() -1; o++) {
    mapa = (mapa+in.right.get(o)*100)*sin(radians(
      (in.bufferSize()/momento)*o));
  }
  recaer();
  //triangle(30*len, 75*len, 58+mapa, 20+mapa, 86+mapa, 75+mapa);
  rect(random(100*len, 185*len), -13, 0, 1*len+mapa);
  translate(len, -len);
  float newLen = len * 0.5;
  if (newLen < 0.5) {
    return;
  } else {
    pushMatrix();
    rotate(radians(random(oll/800, -oll/90)));
    amarr(newLen);
    popMatrix();
    pushMatrix();
    rotate(radians(random(-oll/800, oll/90)));
    amarr(newLen);
    popMatrix();
  }
}

void nube(float len ) {
  for (int o = 100; o < in.bufferSize() -1; o++) {
    mapa = (mapa+in.right.get(o)*100)*sin(radians(
      (in.bufferSize()/momento)*o));
  }
  recaer();
  //triangle(30*len, 75*len, 58+mapa, 20+mapa, 86+mapa, 75+mapa);
  rect(random(len*60, len*40), len, mapa*30, 14);
  translate(1000, len);
  float newLen = len * 0.5;
  if (newLen < 0.5) {
    return;
  } else {
    pushMatrix();
    rotate(radians(random(oll/800, oll/90)));
    nube(newLen);
    popMatrix();
    pushMatrix();
    rotate(radians(oll/800));
    nube(newLen);
    popMatrix();
  }
}

void recaer() {
  rotate(radians(millis()*0.02));
}

void llorar() {
  rotate(radians(random(girar)));
}


void stop() {
  in.close();
  minim.stop();
  super.stop();
}