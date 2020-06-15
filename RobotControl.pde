/*
Approach to send URScript commands to a UR-Robot 
 URScript Reference: http://www.me.umn.edu/courses/me5286/robotlab/Resources/scriptManual-3.5.4.pdf
 */

import processing.net.*;
import java.nio.*;

URobot robot;
float xVal = 0;
float yVal = 0; //the distance from the origin of the robot to the drawing surface
float zVal = 0;

void setup() {
  size(640, 480,P3D);
  robot = new URobot(this, "192.168.9.2");
}

void draw() {
  background(0);
  fill(150,0,0);
  circle(200,40,5);
    circle(100,300,5);
  circle(500,400,5);
  robot.test(); 
  //if(frameCount > 10) exit();
  if (rotationMode && !robot.robotModeData.isProgramRunning) {
    float a = map (mouseX, 0, width, -PI, PI);
    float b = map (mouseY, 0, height, -PI, PI);
    float c = map (mouseX-mouseY, 0, 100, -PI, PI); //extra
    cPose.rx = a;
    cPose.ry = b;
    cPose.rz = c; //extra
    robot.movel(cPose);
    background(255,0,0);
    rotationMode = false;
  }
  
  text("X = " + xVal, 10, 20);
  text("Y = " + yVal, 10, 40);
  text("Z = " + zVal, 10, 60);
}

boolean rotationMode = false;

Pose cPose;

void keyPressed() {
  if (key == 'h') {
    robot.moveHome();
  }
  if (key == 'r') {
    rotationMode = !rotationMode;
    cPose = robot.getCurrentPose();
  }
  if(key == 'w') {
   yVal -= 0.02;
  }
  if(key == 's') {
   yVal += 0.02;
  }
  if(key == 'a') {
   Pose a = new Pose(0.37, -0.8, 0.336, PI/2.0, 0, 0); //point to
   Pose b = new Pose(0, -0.6, 0.86, PI/2.0, 0, 0); //passing through
   robot.movec(b, a,0.1);
  }
  
}


void mousePressed() {
  xVal = map (mouseX, 0, width, -0.5, 0.5);
  yVal = map ((mouseY-mouseX), 0, 100, 0.3, -0.1); //extra
  zVal = map (mouseY, 0, height, 0.9, -0.3);
  

  
  if (!robot.robotModeData.isProgramRunning) {
    robot.movej(new Pose(xVal,-0.7, zVal, PI/2.0, 0, 0), 0.25);
  }
  
}
