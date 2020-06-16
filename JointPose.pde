class JointPose {
  String pose;
  float joint0, joint1, joint2, joint3, joint4, joint5;

  JointPose(float _joint0, float _joint1, float _joint2, float _joint3, float _joint4, float _joint5) {
    joint0 = _joint0; joint1 = _joint1; joint2 = _joint2;
    joint3 = _joint3; joint4 = _joint4; joint5 = _joint5;
  }
  
  JointPose() {
    joint0 = -1.6006415; joint1 = -1.7271778; joint2 = -2.20295458;
    joint3 = -0.80791291; joint4 = 1.5950564; joint5 = -0.03106686;
  }
  
  String toString() {
    return String.format("[%.9s, %.9s, %.9s, %.9s, %.9s, %.9s]", joint0, joint1, joint2, joint3, joint4, joint5);
  }
}
