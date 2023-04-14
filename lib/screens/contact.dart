import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/models/Todo.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class ContactPage extends NyStatefulWidget{

  ContactPage({Key? key}) : super(key: key,routeName: "/contact");
  @override
  _ContactPageState createState() => _ContactPageState();

}
class _ContactPageState extends NyState<ContactPage>{

  @override
  Widget build(BuildContext context) {
    const title = "LIÊN HỆ";
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
  "Liên hệ 1",
  "Liên hệ 2",
  "Liên hệ 3",
];
