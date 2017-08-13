import oscP5.*;
import netP5.*;

OscP5 oscP5;
color backgroundColour;
void setup() {
  size(displayWidth, displayHeight,P2D);
  oscP5 = new OscP5(this, 7111);
  colorMode(HSB, 100);
  smooth();
  noStroke();
  backgroundColour=color(0,0,0);
}

void draw() {
  background(backgroundColour);
}

void oscEvent(OscMessage m) {
  if(m.checkTypetag("fff")) {
    float hue = m.get(0).floatValue();
    float saturation = m.get(1).floatValue();
    float brightness = m.get(2).floatValue();
    backgroundColour = color(hue, saturation, brightness);
    backgroundColour = color(1,1,1);
  }
}