import 'package:socket_io_client/socket_io_client.dart' as IO;

socketFactory(String ip, String version) {
  IO.Socket socket = IO.io(
      ip,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .disableReconnection()
          .build());

  socket.onConnect((data) => {print("connect $data")});

  socket.on('central.init', (data) {
    print('central.init $data');
    socket.emit("central.init");
  });
  socket.on('infos', (data) {
    socket.emit('infos', {"hardwareserial": "toto", "version": version});
  });
  socket.onConnectError((data) => print(data));
  socket.onConnect((_) {
    print('connect ${socket.id}');
  });

  socket.on("error", (err) {
    print(err);
  });

  socket.onDisconnect((_) => print('disconnect'));

  return socket;
}
