import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class DataHandler {
  TcpSocketConnection socketConnection =
      TcpSocketConnection("127.0.0.1", 13000);
  String message = "";
  void messageReceived(String msg) {
    message = msg;
    socketConnection.sendMessage("message");
    print(message);
  }

  void startConnection() async {
    socketConnection.enableConsolePrint(true);
    if (await socketConnection.canConnect(5000, attempts: 1000)) {
      await socketConnection.connect(5000, messageReceived, attempts: 1000);
    }
  }
}
