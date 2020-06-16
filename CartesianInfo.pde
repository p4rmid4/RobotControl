class CartesianInfo extends SubPackage{    
  double x;
  double y;
  double z;
  double rx;
  double ry;
  double rz;
  double tcpOffsetX;
  double tcpOffsetY;
  double tcpOffsetZ;
  double tcpOffsetRx;
  double tcpOffsetRy;
  double tcpOffsetRz;

  CartesianInfo(ByteBuffer message) {    
    super(message, RobotStatePackageType.CARTESION_INFO);
    ByteBuffer msg = message.duplicate();
    msg.position(position);
    x = msg.getDouble();
    y = msg.getDouble();
    z = msg.getDouble();
    rx = msg.getDouble();
    ry = msg.getDouble();
    rz = msg.getDouble();
    tcpOffsetX = msg.getDouble();
    tcpOffsetY = msg.getDouble();
    tcpOffsetZ = msg.getDouble();
    tcpOffsetRx = msg.getDouble();
    tcpOffsetRy = msg.getDouble();
    tcpOffsetRz = msg.getDouble();
  }  
  
  void printData() {
    println("---- ROBOT CARTESIAN INFO ----");
    println("Package Size: " + packageSize);
    println("Package Type: " + packageType);
    println(String.format("X: %s Y: %s Z: %s RX: %s RY: %s RZ: %s", x, y, z, rx, ry, rz)); 
    println(String.format("tcpOffsetX: %s tcpOffsetY: %s tcpOffsetZ: %s tcpOffsetRx: %s tcpOffsetRy: %s tcpOffsetRz: %s", tcpOffsetX, tcpOffsetY, tcpOffsetZ, tcpOffsetRx, tcpOffsetRy, tcpOffsetRz)); 
    println();
  }
}
