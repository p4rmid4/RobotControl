/*
 Approach to send URScript commands to a UR-Robot 
 URScript Reference: http://www.me.umn.edu/courses/me5286/robotlab/Resources/scriptManual-3.5.4.pdf
 
 The controller is always providing data representing the robot's state, such as 
 positions, temperatures, etc. through a few server sockets in the controller. 
 The data transmitted from each server socket could be different in detail to each 
 other. A custom program can be written to read these streams. A full description
 (excel sheet) can be downloaded here:
 
 https://s3-eu-west-1.amazonaws.com/ur-support-site/16496/Client_Interface_V3.13andV5.8.xlsx
 */

import processing.net.*;
import java.nio.*;
import controlP5.*;

URobot robot;

void setup() {
  size(640, 480);
  robot = new URobot(this, "192.168.0.206");
  //textMode(SHAPE);
}

void draw() {
  background(0);  
  displayRobotInfo();
}

void keyPressed() {
  if (key == 'h') {
    robot.moveHome();
  }
  if (key == 'q') {    
    robot.movel(new Pose(), 0.6);
  }
  if (key == 'w') {    
    robot.movej(new JointPose(), 0.6);
  }
}

void mousePressed() {
}

void createUI() {
}

void displayRobotInfo() {
  if (robot.versionMessage != null) {
    push();    
    String name = robot.versionMessage.projectName;
    int majorVersion = robot.versionMessage.majorVersion;
    int minorVersion = robot.versionMessage.minorVersion;
    int bugFixVersion = robot.versionMessage.bugFixVersion;
    int buildNumber = robot.versionMessage.buildNumber;
    String buildDate = robot.versionMessage.buildDate;
    fill(255);
    textAlign(CENTER, BOTTOM);
    textSize(9);
    text(String.format("Universal Robots Software: %s %s.%s.%s.%s | %s", name, majorVersion, minorVersion, bugFixVersion, buildNumber, buildDate), width/2, height-10);
    
    textSize(13);
    textAlign(LEFT, CENTER);
    if(robot.isProgramRunning) {
      fill(255,0,0);
      text("Robot Status: RUNNING", 10, 20);
    } else {
      fill(0,255,0);
      text("Robot Status: STOPPED", 10, 20);      
    }
    
    fill(255);
    text("CARTESIAN INFO:", 10, 50);
    textAlign(LEFT, TOP);
    textSize(11);
    text(String.format("X: %.4f m\nY: %.4f m\nZ: %.4f m", robot.currentPose.x, robot.currentPose.y, robot.currentPose.z), 10, 65);
    text(String.format("RX: %.4f rad\nRY: %.4f rad\nRZ: %.4f rad", robot.currentPose.rx, robot.currentPose.ry, robot.currentPose.rz), 10, 120);
    
    textSize(13);
    textAlign(LEFT, CENTER);
    text("JOINT ROTATIONS:", 10, 190);
    textAlign(LEFT, TOP);
    textSize(11);
    text(String.format("JOINT_0: %.4f rad\nJOINT_1: %.4f rad\nJOINT_2: %.4f rad", robot.currentJointPose.joint0, robot.currentJointPose.joint1, robot.currentJointPose.joint2), 10, 205);
    text(String.format("JOINT_3: %.4f rad\nJOINT_4: %.4f rad\nJOINT_5: %.4f rad", robot.currentJointPose.joint3, robot.currentJointPose.joint4, robot.currentJointPose.joint5), 10, 260);
    pop();
  }
}
