import 'dart:io';

ServerSocket server;

void main() {
  ServerSocket.bind(InternetAddress.ANY_IP_V4, 4567)
      .then((ServerSocket socket) {
    server = socket;
    server.listen((client) {
      handleConnection(client);
    });
  });
}

void handleConnection(Socket client){
  print('Connection from '
      '${client.remoteAddress.address}:${client.remotePort}');

  clients.add(new ChatClient(client));

  client.write("Welcome to dart-chat! "
      "There are ${clients.length - 1} other clients\n");
}

void removeClient(ChatClient client){
  clients.remove(client);
}
List<ChatClient> clients = [];

void distributeMessage(ChatClient client, String message){
  for (ChatClient c in clients) {
    if (c != client){
      c.write(message + "\n");
    }
  }
}


class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(Socket s){
    _socket = s;
    _address = _socket.remoteAddress.address;
    _port = _socket.remotePort;

    _socket.listen(messageHandler,
        onError: errorHandler,
        onDone: finishedHandler);
  }

  void messageHandler(Iterable data){
    String message = new String.fromCharCodes(data).trim();
    distributeMessage(this, '${_address}:${_port} Message: $message');
  }

  void errorHandler(error){
    print('${_address}:${_port} Error: $error');
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    print('${_address}:${_port} Disconnected');
    removeClient(this);
    _socket.close();
  }

  void write(String message){
    _socket.write(message);
  }
}
