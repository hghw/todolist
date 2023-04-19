import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:todolist/controllers/listdodo_controller.dart';
import 'package:todolist/models/Todo.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../config/storage_keys.dart';

final TextEditingController inputElement = TextEditingController();
final TextEditingController editElement = TextEditingController();
final ScrollController listView = ScrollController();

int _id = 0;
List<Todo> _listData = [];

class Create extends NyStatefulWidget {
  final ListTodoController controller = ListTodoController();

  Create({Key? key}) : super(key: key, routeName: "/create");

  @override
  NyState<Create> createState() => _CreateState();
}

class _CreateState extends NyState<Create> {
  @override
  init() async {
    _listData = (await widget.controller.list())!;

    int? idStorage = await NyStorage.read("_id");

    if (idStorage != null) {
      _id = idStorage + 1;
    }

    super.init();
  }

  @override
  Widget build(BuildContext context) {
    const title = "TODO LIST";
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(children: [
        Align(child: InputView(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [ButtonClear(context), ButtonSubmit(context)],
        ),
        Expanded(
            child: ListView.builder(
                itemCount: _listData.length,
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (_listData.isEmpty) {
                    return null;
                  }
                  return ListTile(
                    title: Text(_listData[index].description),
                    leading: ShowModal(id: index),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShowEditModal(index),
                        DeleteButton(index),
                      ],
                    ),
                  );
                }))
      ]),
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
    );
  }

  //Widget ButtonSubmit
  @override
  Widget ButtonSubmit(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {
            if (inputElement.text.isEmpty) {
              ShowNotification(context, "Thông tin trống!", "");
            } else {
              setState(() {
                _addData(inputElement.text);
              });
            }
          },
          child: const Text(
            "Thêm mới",
            // style: TextStyle(color: Colors.white),
          )),
      margin: EdgeInsets.all(15),
      //color: Colors.green,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15)),
    );
  }

  //Widget ButtonClear
  Widget ButtonClear(BuildContext context) {
    return TextButton(
        onPressed: () {
          setState(() {
            _listData.clear();
            NyStorage.deleteAll();
          });
        },
        child: const Text("Xóa tất cả"));
  }

  //Widget InputView
  @override
  Widget InputView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      child: TextField(
        controller: inputElement,
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Điền thông tin..."),
        onSubmitted: (val) {
          if (inputElement.text.isEmpty) {
            ShowNotification(context, "Thông tin trống!", "");
          } else {
            setState(() {
              _addData(inputElement.text);
            });
          }
        },
      ),
    );
  }

  //Widget DeleteButton
  @override
  Widget DeleteButton(int index) {
    return TextButton(
        onPressed: () {
          setState(() {
            _deleteItem(index);
          });
        },
        child: Icon(Icons.delete, color: Colors.red));
  }

  @override
  Widget ShowEditModal(int id) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog.fullscreen(
                // height: 3000,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(40)),
                      const Text(
                        'CHỈNH SỬA THÔNG TIN',
                        style: TextStyle(fontSize: 25),
                      ),
                      Padding(padding: EdgeInsets.all(40)),
                      InputEdit(id),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            child: Text("Đóng"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: ElevatedButton(
                              child: Text("Sửa"),
                              onPressed: () {
                                setState(() {
                                  _editItem(id);
                                  Navigator.pop(context);
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Icon(Icons.edit),
    );
  }

  //Widget InputEdit
  @override
  Widget InputEdit(int id) {
    editElement.text = _listData[id].description;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Mô tả",
              textAlign: TextAlign.start,
            ),
          ),
          TextField(
            controller: editElement,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Điền thông tin..."),
            onSubmitted: (val) {
              if (editElement.text.isEmpty) {
                ShowNotification(context, "Thông tin trống!", "");
              } else {
                setState(() {
                  _editItem(id);
                  Navigator.pop(context);
                });
              }
            },
          )
        ],
      ),
    );
  }
}

//Class showmodal
class ShowModal extends StatelessWidget {
  int id;

  ShowModal({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Text('Thông tin chi tiết'),
                      Text(_getInfo(id)),
                      ElevatedButton(
                        child: Text("Đóng"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Icon(Icons.info_outline),
    );
  }
}

//Function
Future<void> _addData(String des) async {
  if (des.isNotEmpty) {
    var item = Todo(description: des, id: _id);

    if (item != null) {
      _listData.add(item);

      await NyStorage.store(StorageKey.listTodo,
          jsonEncode(_listData.map((e) => e.toStorage()).toList()));

      await NyStorage.store("_id", _id);
      _id++;
    }
    //clear
    inputElement.clear();
  }
}

void _deleteItem(int index) {
  //remove list
  _listData.remove(_listData[index]);
  //remove item in storage
  NyStorage.deleteAll();
  NyStorage.store(StorageKey.listTodo,
      jsonEncode(_listData.map((e) => e.toStorage()).toList()));
}

void _editItem(int index) {
  //remove list
  _listData[index].description = editElement.text;
  //remove item in storage
  NyStorage.deleteAll();
  NyStorage.store(StorageKey.listTodo,
      jsonEncode(_listData.map((e) => e.toStorage()).toList()));
}

String _getInfo(int index) {
  var item = _listData[index].description;
  return item;
}

class IconMenu {
  IconData icon;
  String title;
  String url;

  IconMenu(this.icon, this.title, this.url);
}

List<IconMenu> _listIcon = [
  new IconMenu((Icons.home), "Trang chủ", "/"),
  new IconMenu((Icons.list), "Danh sách", "/create"),
  new IconMenu((Icons.call), "Liên hệ", "/lienhe"),
  new IconMenu((Icons.notifications), "Thông báo", "/notification"),
];

Future ShowNotification(BuildContext context, title, String content) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
              //actionsAlignment: MainAxisAlignment.spaceEvenly,
              title: Center(child: Text(title.isNotEmpty ? title : "Lỗi!")),
              //content: Center(child: Text(content.isNotEmpty ? content : "Lỗi!")),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Đóng"))
              ]));
}
