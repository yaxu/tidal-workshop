#include <DmxMaster.h>

void setup() {
  Serial.begin(115200);
  //Serial.println("SerialToDmx ready");
}

int channel;

int value = 0;

void loop() {
  int c;

  while(!Serial.available());
  c = Serial.read();
  if ((c >= '0') && (c <= '9')) {
    value = 10*value + c - '0';
  }
  else {
    if (c=='r') {
      DmxMaster.write(2, value);
      //Serial.println("setting channel 1");
    }
    else if (c=='g') {
      DmxMaster.write(3, value);
      //Serial.println("setting channel 2");
    }
    else if (c=='b') {
      DmxMaster.write(4, value);
      //Serial.println("setting channel 3");
    }
    else if (c=='l') {
      DmxMaster.write(1, value);
      //Serial.println("setting channel 3");
    }
    else if (c=='R') {
      DmxMaster.write(6, value);
      //Serial.println("setting channel 1");
    }
    else if (c=='G') {
      DmxMaster.write(7, value);
      //Serial.println("setting channel 2");
    }
    else if (c=='B') {
      DmxMaster.write(8, value);
      //Serial.println("setting channel 3");
    }    
    else if (c=='L') {
      DmxMaster.write(5, value);
      //Serial.println("setting channel 3");
    }    
    else if (c=='x') {
      for (int i = 0; i < 8; ++i) {
        DmxMaster.write(i+1, 0);
      }
      //Serial.println("panic over");
    }    
    value = 0;
  }
}
