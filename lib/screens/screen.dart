import 'package:flutter/material.dart';

final TextEditingController inputElement = TextEditingController();
final ScrollController listView = ScrollController();
List<String> _listData = [];

class Screen extends StatefulWidget {
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    const title = "TODO LIST";
    return MaterialApp(
      title: title,
      home: Scaffold(
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
                    //print(index);
                    return ListTile(
                      title: Text(_listData[index]),
                      leading: ShowModal(id: index),
                      trailing: DeleteButton(index),
                    );
                  }))
        ]),
        floatingActionButton: FloatingActionButton(
          tooltip: "Nhấn nút để thực thi",
          onPressed: () {
            setState(() {
              _addData(inputElement.text);
            });
          },
          child: const Icon(Icons.add),
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
            setState(() {
              _addData(inputElement.text);
            });
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
          });
        },
        child: const Text("Xóa tất cả"));
  }

  //Widget InputView
  Widget InputView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      child: TextField(
        controller: inputElement,
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Điền thông tin..."),
        onSubmitted: (val) {
          setState(() {
            _addData(inputElement.text);
          });
        },
      ),
    );
  }

  //Widget DeleteButton
  Widget DeleteButton(int index) {
    return TextButton(
        onPressed: () {
          setState(() => {_deleteItem(index)});
        },
        child: Icon(Icons.delete, color: Colors.red));
  }
}

class ShowModal extends StatelessWidget {
  int id;
  ShowModal({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(context: context, builder: (BuildContext context) {
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
void _addData(String item) {
  if (item.length > 0) {
    _listData.add(item);
  }
  inputElement.clear();
}

void _deleteItem(int index) {
  _listData.remove(_listData[index]);
}

String _getInfo(int index){
  var item = _listData[index];
  return item;
}