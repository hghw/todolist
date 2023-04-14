import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/models/Todo.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class NotificationPage extends NyStatefulWidget {
  List<Todo> listData = [];

  //NotificationPage(this.listData) : super();
  NotificationPage({Key? key}) : super(key: key, routeName: "/notification");

  @override
  _NotificationClassState createState() => _NotificationClassState();
}

class _NotificationClassState extends NyState<NotificationPage> {
  @override
  init() async {
    super.init();
  }

  @override
  Widget build(BuildContext context) {
    const title = "THÔNG BÁO";
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: ListView.builder(
                  itemCount: listNotification.length,
                  itemBuilder: (context, index) {
                if (listNotification == null) {
                  return null;
                }
                return ListTile(
                  title: Text(listNotification[index]),
                  leading: Icon(Icons.insert_drive_file),
                  trailing: Icon(Icons.access_time_outlined),
                );
              }))
            ]),
      ),
    );
  }
}

List<String> listNotification = [
  "Thông báo 1",
  "Thông báo 2",
  "Thông báo 3",
  "Thông báo 4",
  "Thông báo 5",
];
