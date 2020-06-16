class JointData extends SubPackage{  
  JointInstanceData[] individualJoints = new JointInstanceData[6];

  JointData(ByteBuffer message) {
    super(message, RobotStatePackageType.JOINT_DATA);
    ByteBuffer msg = message.duplicate();
    msg.position(position);   
    
    for(int i = 0; i < individualJoints.length; i++) {
      individualJoints[i] = new JointInstanceData(msg);
    }
  }

  void printData() {
    println("---- ROBOT JOINT DATA ----");
    println("Package Size: " + packageSize);
    println("Package Type: " + packageType);
    for(int i = 0; i < individualJoints.length; i++) {
      println(String.format("Joint #%s q_actual: %.9s", i, individualJoints[i].q_actual));
      println(String.format("Joint #%s q_target: %.9s", i, individualJoints[i].q_target));
      println(String.format("Joint #%s qd_actual: %.9s", i, individualJoints[i].qd_actual));
      println(String.format("Joint #%s I_actual: %.9s", i, individualJoints[i].I_actual));
      println(String.format("Joint #%s V_actual: %.9s", i, individualJoints[i].V_actual));
      println(String.format("Joint #%s T_motor: %.9s", i, individualJoints[i].T_motor));
      println(String.format("Joint #%s T_micro: %.9s", i, individualJoints[i].T_micro));
      println(String.format("Joint #%s jointMode: %s", i, individualJoints[i].jointMode));
    } 
    println();
  }
}

class JointInstanceData {  
  double q_actual;
  double q_target;
  double qd_actual;
  float I_actual;
  float V_actual;
  float T_motor;
  float T_micro;
  JointMode jointMode;

  JointInstanceData(ByteBuffer message) {
    ByteBuffer msg;
    msg = message;
    q_actual = msg.getDouble();
    q_target = msg.getDouble();
    qd_actual = msg.getDouble();
    I_actual = msg.getFloat();
    V_actual = msg.getFloat();
    T_motor = msg.getFloat();
    T_micro = msg.getFloat();
    jointMode = JointMode.get(msg.get());
  }
}
