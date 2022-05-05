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

  var light1Status = 'N/A';
  var light2Status = 'N/A';

  var outlet1Status = 'N/A';
  var outlet2Status = 'N/A';
  var outlet3Status = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('CONTROL PANEL',
                style:
                    const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var status = snapshot.data.toString();
                  var split = status.split("-");
                  if (split[0] == "light1") {
                    // setState(() {
                    light1Status = split[1];
                    // });
                  }
                  if (split[0] == "light2") {
                    // setState(() {
                    light2Status = split[1];
                    // });
                  }
                  if (split[0] == "outlet1") {
                    // setState(() {
                    outlet1Status = split[1];
                    // });
                  }
                  if (split[0] == "outlet2") {
                    // setState(() {
                    outlet2Status = split[1];
                    // });
                  }
                  if (split[0] == "outlet3") {
                    // setState(() {
                    outlet3Status = split[1];
                    // });
                  }
                }
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("LIGHT 1",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              Text(light1Status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                          const SizedBox(
                            width: 34,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("LIGHT 2",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              Text(light2Status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("OUTLET 1",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              Text(outlet1Status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                          const SizedBox(
                            width: 34,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("OUTLET 2",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              Text(outlet2Status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                          const SizedBox(
                            width: 34,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("OUTLET 3",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              Text(outlet3Status,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                    ]);
              },
            ),
            const SizedBox(height: 21),
            Center(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("BLINDS",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("LIGHTS",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "OPEN PANEL",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => showLightsPanel(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OUTLETS",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          ElevatedButton(
                            child: const Text(
                              "OPEN PANEL",
                              style: TextStyle(fontSize: 21),
                            ),
                            onPressed: () => showOutletsPanel(context),
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

  void showLightsPanel(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 200.0),
              child: AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("LIGHT 1",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                              width: 21,
                              height: 21,
                            ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: const Text(
                                      "ON",
                                      style: TextStyle(fontSize: 21),
                                    ),
                                    onPressed: () => sendCommand("light1-on"),
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
                                    onPressed: () => sendCommand("light1-off"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("LIGHT 2",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                              width: 21,
                              height: 21,
                            ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: const Text(
                                      "ON",
                                      style: TextStyle(fontSize: 21),
                                    ),
                                    onPressed: () => sendCommand("light2-on"),
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
                                    onPressed: () => sendCommand("light2-off"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
            ));
  }

  void showOutletsPanel(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 200.0),
              child: AlertDialog(
                  content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("OUTLET 1",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                        const SizedBox(
                              width: 21,
                              height: 21,
                            ),
                        Row(
                          children: [
                            ElevatedButton(
                              child: const Text(
                                "ON",
                                style: TextStyle(fontSize: 21),
                              ),
                              onPressed: () => sendCommand("outelet1-on"),
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
                              onPressed: () => sendCommand("outelet1-off"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("OUTLET 2",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                        const SizedBox(
                              width: 21,
                              height: 21,
                            ),
                        Row(
                          children: [
                            ElevatedButton(
                              child: const Text(
                                "ON",
                                style: TextStyle(fontSize: 21),
                              ),
                              onPressed: () => sendCommand("outlet2-on"),
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
                              onPressed: () => sendCommand("outlet2-off"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("OUTLET 3",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(
                              width: 21,
                              height: 21,
                            ),
                          Row(
                            children: [
                              ElevatedButton(
                                child: const Text(
                                  "ON",
                                  style: TextStyle(fontSize: 21),
                                ),
                                onPressed: () => sendCommand("outlet3-on"),
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
                                onPressed: () => sendCommand("outlet3-off"),
                              ),
                            ],
                          ),
                        ]),
                  ])),
            ));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
