class CartesianInfo {
  ByteBuffer msg;
  int packageSize;
  RobotStatePackageType packageType;
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
    msg = message;
    packageSize = msg.getInt();
    packageType = RobotStatePackageType.get(msg.get());
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

  void printCartesianInfo() {
    println("---- ROBOT CARTESIAN INFO ----");
    println("Package Size: " + packageSize);
    println("Package Type: " + packageType);
    println(String.format("X: %s Y: %s Z: %s RX: %s RY: %s RZ: %s", x, y, z, rx, ry, rz)); 
    println(String.format("tcpOffsetX: %s tcpOffsetY: %s tcpOffsetZ: %s tcpOffsetRx: %s tcpOffsetRy: %s tcpOffsetRz: %s", tcpOffsetX, tcpOffsetY, tcpOffsetZ, tcpOffsetRx, tcpOffsetRy, tcpOffsetRz)); 
    println();
  }
}
