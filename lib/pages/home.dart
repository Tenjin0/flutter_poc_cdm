import 'package:flutter/material.dart';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:poc_cdm/helpers/socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:poc_cdm/widget/socketForm.dart';
import 'package:poc_cdm/widget/notificationForm.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  IO.Socket? socket;
  BuildContext? homeContext;

  @override
  void initState() {
    // print('initState');
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // deviceInfo.androidInfo.then((androidInfo) {
    //   print('Running on ${androidInfo.id}'); // e.g. "Moto G (4)"
    //   print('Running on ${androidInfo.androidId}'); // e.g. "Moto G (4)"
    //   print('Running on ${androidInfo.isPhysicalDevice}'); // e.g. "Moto G (4)"
    // });

    super.initState();
  }

  @override
  void dispose() {
    // print('dispose');

    if (this.socket!.connected) {
      this.socket!.disconnect();
    }
    super.dispose();
  }

  onValidateSocket(String host, String port, String namespace) {
    // print("$host $port $namespace");
    // print("${this.socket == null}");
    if (this.socket == null) {
      // print('socket creation');
      this.socket = socketFactory('http://$host:$port/$namespace', "1.0.0");
      this.socket!.on('error', (dynamic err) {
        print("${err}");
        String message = err!.message;
        final snackBar = SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
      });
      this.socket!.connect();
    } else {
      this.socket!.disconnect();
      this.socket!.close();
      this.socket = null;
    }
  }

  onValidateNotification(String message) {
    if (this.socket!.connected) {
      this.socket!.emit('@cdm/notification', message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // String connect = "Disconnected";
    // print(this.socket != null);
    // print(this.socket?.connected);
    // if (this.socket != null && this.socket!.connected) {
    //   connect = "Connected";
    // }

    this.homeContext = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('device manager poc'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SocketForm(
              onValidate: this.onValidateSocket,
            ),
            NotificationForm(
              onValidate: this.onValidateNotification,
            )
          ],
        ),
      ),
    );
  }
}
