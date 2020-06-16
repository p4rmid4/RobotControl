class URobot {
  Client client;
  String robotIP;
  int robotPort;
  JointPose homePosition;
  Pose currentPose;
  JointPose currentJointPose;
  ByteBuffer msg;
  VersionMessage versionMessage;
  RobotPackage robotPackage;
  boolean isProgramRunning;

  URobot(PApplet parent, String _robotIP) {
    robotIP = _robotIP;
    robotPort = 30002;

    client = new Client(parent, robotIP, robotPort);
    homePosition = new JointPose(0, -PI/2, 0, -PI/2, 0, 0);
    msg = null;
    versionMessage = null;
    robotPackage = null;    
    //set_tcp(new Pose(0, 0, 0, 0, 0, 0));
    currentPose = new Pose();
    currentJointPose = new JointPose();
    thread("updateBuffer");
  }

  public void moveHome() {
    client.write("movej(" + homePosition.toString() + ")\n");
  }

  public void movec(Pose p1, Pose p2, float speed) {
    client.write("movec(" + p1.toString() + ", " + p2.toString() + ", v=" + speed + ")\n");
  }

  public void movej(Pose p, float speed) {
    client.write("movej(" + p.toString() + ", v=" + speed + ")\n");
  }

  public void movej(JointPose p, float speed) {
    client.write("movej(" + p.toString() + ", v=" + speed + ")\n");
  }
  
  public void movej(JointPose p) {
    client.write("movej(" + p.toString() + ")\n");
  }

  public void movel(Pose p) {
    client.write("safetyCheck = is_within_safety_limits(" + p.toString() + ")\n");
    client.write("if safetyCheck:\n");    
    client.write("    movel(" + p.toString() + ")\n");
    client.write("else:\n");
  }

  public void movel(JointPose p, float speed) {
    client.write("movel(" + p.toString() + ", v=" + speed +")\n");
  }
  public void movel(Pose p, float speed) {
    client.write("movej(" + p.toString() + ", v=" + speed + ")\n");
  }

  public void movep(Pose p, float speed) {
    client.write("movep(" + p.toString() + ", v=" + speed + ")\n");
  }

  public void movep(JointPose p, float speed) {
    client.write("movep(" + p.toString() + ", v=" + speed + ")\n");
  }

  public void set_tcp(Pose p) {
    client.write("set_tcp(" + p.toString() + ")\n");
  }

  public void getCurrentPose() {    
    float x = (float)robotPackage.cartesianInfo.x;
    float y = (float)robotPackage.cartesianInfo.y;
    float z = (float)robotPackage.cartesianInfo.z;
    float rx = (float)robotPackage.cartesianInfo.rx;
    float ry = (float)robotPackage.cartesianInfo.ry;
    float rz = (float)robotPackage.cartesianInfo.rz;

    Pose p = new Pose(x, y, z, rx, ry, rz);
    currentPose = p;

    x = (float)robotPackage.jointData.individualJoints[0].q_actual;
    y = (float)robotPackage.jointData.individualJoints[1].q_actual;
    z = (float)robotPackage.jointData.individualJoints[2].q_actual;
    rx = (float)robotPackage.jointData.individualJoints[3].q_actual;
    ry = (float)robotPackage.jointData.individualJoints[4].q_actual;
    rz = (float)robotPackage.jointData.individualJoints[5].q_actual;

    JointPose jp = new JointPose(x, y, z, rx, ry, rz);
    currentJointPose = jp;
  }
  

  public void getVersionMessage() {     
    versionMessage = new VersionMessage(msg);
    versionMessage.printVersionInfo();
  }

  public void getLoopMessage() { 
    robotPackage = new RobotPackage(msg);
    robotPackage.printData();
    isProgramRunning = robotPackage.robotModeData.isProgramRunning;
  }

  void offsetBufferData(int times) {
    for (int i =0; i < times; i++) {
      int p = msg.position();
      int s = msg.getInt();      
      msg.position(p + s);
    }
  }
}

// function to update the robot's buffer, intended to run on a separate thread
void updateBuffer() {  
  while (true) {
    if (robot.client.available() > 0) {
      byte[] m = robot.client.readBytes();
      robot.msg = ByteBuffer.wrap(m);

      if (robot.versionMessage == null) {
        robot.getVersionMessage();
      } else {        
        robot.getLoopMessage();
        robot.getCurrentPose();
      }
    }
  }
}
