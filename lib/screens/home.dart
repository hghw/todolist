import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/models/Todo.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:todolist/screens/contact.dart';
import 'package:todolist/screens/create.dart';
import 'package:todolist/screens/notification.dart';

final TextEditingController inputElement = TextEditingController();
final ScrollController listView = ScrollController();

class HomePage extends NyStatefulWidget {
  HomePage({Key? key}) : super(key: key, routeName: "/home");

  @override
  NyState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  @override
  init() async {
    super.init();
  }

  @override
  Widget build(BuildContext context) {
    const title = "TRANG CHỦ";
    return MaterialApp(
      //initialRoute: "/home",
      // routes: {
      //   "/home": (context) =>  HomePage(),
      //     "/create": (context) => Create()
      // },
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 222, 222, 222)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: const [
            BodyContainer(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          tooltip: "Thêm mới",
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: _listIcon.length,
            tabBuilder: (index, isActive) {
              final color = isActive ? Colors.blue : Colors.grey;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          chooseMenu(index);
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            _listIcon[index].icon,
                            size: 28,
                            color: color,
                          ),
                          Text(_listIcon[index].title,
                              style: TextStyle(color: color))
                        ],
                      ))
                ],
              );
            },
            height: 60,
            activeIndex: 0,
            backgroundColor: Colors.white,
            gapLocation: GapLocation.center,
            onTap: (index) {
              //return setState(() => _activeIndex = index);
            }),
      ),
    );
  }

  Future chooseMenu(int index) async {
    switch (index) {
      case 0:
        {
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      case 1:
        {
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => Create()));
          //return Navigator.pushNamed(context, '/create');
        }
      case 2:
        {
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => ContactPage()));
        }
      case 3:
        {
          return Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationPage()));
        }
      default:
        Navigator.pushNamed(context, "/home");
    }
  }
}

class IconMenu {
  IconData icon;
  String title;

  IconMenu(this.icon, this.title);
}

List<IconMenu> _listIcon = [
  IconMenu((Icons.home), "Trang chủ"),
  IconMenu((Icons.list), "Danh sách"),
  IconMenu((Icons.call), "Liên hệ"),
  IconMenu((Icons.notifications), "Thông báo"),
];

class BodyContainer extends StatelessWidget {
  const BodyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(122, 189, 189, 189),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Vị trí', style: TextStyle(color: Colors.white, fontSize: 20),),
            subtitle: Text('Thanh Xuân, Hà Nội.')
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Danh sách', style: TextStyle(color: Colors.white, fontSize: 20),),
            subtitle: Text('Thành viên'),
          ),
        ],
      ),
    );
  }
}
