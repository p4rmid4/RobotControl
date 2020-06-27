import processing.net.*;
import java.nio.*;
import controlP5.*;

URobot robot;

void setup() {
  size(640, 480);
  robot = new URobot(this, "192.168.0.206");
 
}

void draw() {
  background(0);  
  
}

void keyPressed() {
  
}

void mousePressed() {
}
