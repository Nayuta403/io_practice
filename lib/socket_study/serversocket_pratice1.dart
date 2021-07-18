import 'dart:io';

void main() {
  ServerSocket.bind(InternetAddress.anyIPv4, 4567)
      .then((ServerSocket server) {
    server.listen(handleClient);
  });
}

void handleClient(Socket client) {
  print('Connection from '
      '${client.remoteAddress.address}:${client.remotePort}');
  client.write("Hello from simple server!\n");
  client.close();
}
