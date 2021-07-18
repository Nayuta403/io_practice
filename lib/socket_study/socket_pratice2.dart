import 'dart:io';

void main() {
  String indexRequest = 'GET / HTTP/1.1\nConnection: close\n\n';

  //与百度通过 80 端口连接
  Socket.connect("www.baidu.com", 80).then((socket) {
    print('Connected to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');

    //监听 socket 的数据返回
    socket.listen((data) {
      print(new String.fromCharCodes(data).trim());
    }, onDone: () {
      print("Done");
      socket.destroy();
    });

    //发送数据
    socket.write(indexRequest);
  });
}
