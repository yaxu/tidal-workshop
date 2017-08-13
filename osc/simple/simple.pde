import oscP5.*;
import netP5.*;

OscP5 oscP5;

class Event {
  double when;
  float dur;
  String type;
  int n;
  float x;
  float y;
  float hue;
  
};

ArrayList<Event> future = new ArrayList<Event>();
ArrayList<Event> history = new ArrayList<Event>(); 
float maxage = 0.5; // seconds

String type = "strobe";
float x[] = new float[2];
float y[] = new float[2];
int things = 2;

int csz = 10;
String mode = "tail";


void setup() {
  size(displayWidth, displayHeight,P2D);
//  size(400, 400,P2D);
  oscP5 = new OscP5(this, 7110);
  colorMode(HSB, 100);
  smooth();
  noStroke();
}

void draw() {
  double now = (double) System.currentTimeMillis() / 1000;
  //float hyp = width/4;
  //float direction = TWO_PI * (hz/400);
  //float x = width/2 + sin(direction) * hyp;
  //float y = height/2 + cos(direction) * hyp;
  ArrayList<Event> remove = new ArrayList<Event>();
  synchronized(future) {
    for (Event e : future) {
      if (e.when <= now) {
        remove.add(e);
      }
    }
    for (Event e : remove) {
      future.remove(e);
      history.add(e);
      println("add to history, now " + history.size());
    }
    remove.clear();
  } 
 
  background(0);
  
  for (int n = 0; n < things; ++n) {
    Event prevline = null;
    for (Event e : history) {
      if (e.n != n) {
        continue;
      }

      if (e.type.equals("line")) {
          //  println("'" + e.type + "'");
         if (prevline != null) {
           strokeWeight(400);
           stroke(e.hue,100,100);
           println("draw " + prevline.x + "x" + prevline.y + " to " + e.x + "x" + e.y);
           line(prevline.x, prevline.y, e.x,e.y);
         }
         prevline = e;
      }
      else if (e.type.equals("strobe")) {
        noStroke();
        println("strobe");
        fill(e.hue,0,100);
       
        rect(0,0,width,height);
      }
    }
  }
  
  for (Event e : history) {
      if (e.when <= (now-e.dur)) {
        remove.add(e);
      }    
  }
  for (Event e : remove) {
    history.remove(e);
  }
  
}

void oscEvent(OscMessage m) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+m.addrPattern());
  //println(" typetag: "+m.typetag());
  
  
  if(m.checkTypetag("iiffisffff")) {
    int sec = m.get(0).intValue();
    int usec = m.get(1).intValue();
    double when = (double) sec + (usec / 1000000.0f);
    float cps  = m.get(2).floatValue();
    double offset = m.get(3).floatValue();
    when += offset;
    Event e = new Event();
    e.when = when;
    e.n    = m.get(4).intValue();
    e.type = m.get(5).stringValue();
    e.x    = m.get(6).floatValue()* (float)width;
    e.y    = m.get(7).floatValue()*(float)height;
    e.hue  = m.get(8).floatValue()*100.0;
    e.dur  = m.get(9).floatValue() * cps; 
   println(e.dur + " " + cps + " " + m.get(9).floatValue());
    synchronized(future) {
      future.add(e);
    }
    println("[" + when + "]Got type " + e.type + " " + e.x + "x" + e.y + " dur " + e.dur);
  }
  if (m.checkTypetag("s")) {
    mode = m.get(0).stringValue();
  }
  
}