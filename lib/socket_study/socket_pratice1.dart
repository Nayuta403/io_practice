import 'dart:io';

void main() {
  Socket.connect("www.baidu.com", 4567).then((socket) {
    print('Connected to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');
    socket.destroy();
  });
}
