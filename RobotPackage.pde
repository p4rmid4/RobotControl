class RobotPackage {
  int messageSize;
  MessageType messageType;

  RobotModeData  robotModeData;
  JointData jointData;
  CartesianInfo cartesianInfo;  

  RobotPackage(ByteBuffer message) {
    ByteBuffer msg = message.duplicate();
    messageSize = msg.getInt();
    messageType = MessageType.get(msg.get());

    robotModeData = new RobotModeData(msg);    
    jointData = new JointData(msg);
    cartesianInfo = new CartesianInfo(msg);   
  }
  
  void printData() {
    robotModeData.printData();
    jointData.printData();
    cartesianInfo.printData();
  }
}

abstract class SubPackage {
  int packageSize;
  RobotStatePackageType packageType;
  int position;

  SubPackage(ByteBuffer message, RobotStatePackageType type) {
    ByteBuffer msg = message.duplicate();
    packageSize = msg.getInt();
    packageType = RobotStatePackageType.get(msg.get());
    searchSubPackage(msg, type);
    position = msg.position();
  }

  void searchSubPackage(ByteBuffer msg, RobotStatePackageType type) {
    while (packageType != type) {      
      msg.position(msg.position() + packageSize - 5);
      packageSize = msg.getInt();
      packageType = RobotStatePackageType.get(msg.get());
    }
  }

  abstract void printData();
}
