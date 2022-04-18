import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Arduino control pannel';
    return const MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.1.16:3000/'),
  );

  var ledStatus = 'No data sent';
  var lightStatus = 'No data sent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: _channel.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var status = snapshot.data.toString();
                        var split = status.split("-");
                        if (split[0] == "led") {
                          // setState(() {
                            ledStatus = split[1];
                          // });
                        }
                        if (split[0] == "light") {
                          // setState(() {
                            lightStatus = split[1];
                          // });
                        }
                      }
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Arduino led status:",
                                style: TextStyle(
                                    fontSize: 34, fontWeight: FontWeight.bold)),
                            Text(ledStatus,
                                style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54)),
                            const SizedBox(
                              height: 34,
                            ),
                            const Text("Arduino light status:",
                                style: TextStyle(
                                    fontSize: 34, fontWeight: FontWeight.bold)),
                            Text(lightStatus,
                                style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54))
                          ]);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Center(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("LED"),
                      Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "ON",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("led-on"),
                          ),
                          const SizedBox(
                            width: 21,
                            height: 21,
                          ),
                          ElevatedButton(
                            child: const Text(
                              "OFF",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("led-off"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("LIGHT"),
                      Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "ON",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("light-on"),
                          ),
                          const SizedBox(
                            width: 21,
                            height: 21,
                          ),
                          ElevatedButton(
                            child: const Text(
                              "OFF",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("light-off"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BLINDS"),
                      Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "UP",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("blinds-up"),
                          ),
                          const SizedBox(
                            width: 21,
                            height: 21,
                          ),
                          ElevatedButton(
                            child: const Text(
                              "DOWN",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => sendCommand("blinds-down"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _sendMessage,
      //   tooltip: 'Send message',
      //   child: const Icon(Icons.send),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    _channel.sink.add("register:mobile");
    super.initState();
  }

  void sendCommand(command) {
    _channel.sink.add("command:" + command);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
