// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_push_notfication/Screen/demo.dart';
import 'package:flutter_push_notfication/api/local_noti_api.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class LocallyNotfication extends StatefulWidget {
  const LocallyNotfication({Key? key}) : super(key: key);

  @override
  State<LocallyNotfication> createState() => _LocallyNotficationState();
}

class _LocallyNotficationState extends State<LocallyNotfication> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    NotificationApi.init();
    listenNotifications();
  }

  listenNotifications() =>
      NotificationApi.onNotification.stream.listen(onClickNotification);

  void onClickNotification(String? payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DemoScreen(
            id: payload as String,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("local notfication"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  NotificationApi.showNotification(
                      title: "shubham",
                      payload: " हेलो तो कसी है आप लोग",
                      body: "hello");
                },
                child: const Text("Simple Notification"),
              ),
              ElevatedButton(
                onPressed: () {
                  NotificationApi.showScheduleNotification(
                      title: "hello",
                      body: "bookh lagi hai",
                      payload: " हेलो तो कसी है आप लोग",
                      scheduledDate: DateTime.now().add(Duration(seconds: 5)));
                  final snakBar = SnackBar(
                      content: Text(
                        "scheduled in 5 second",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      backgroundColor: Colors.amberAccent);
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snakBar);
                },
                child: const Text("Schedule Notification"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("remove  Notification"),
              ),
            ]),
      ),
    );
  }
}
