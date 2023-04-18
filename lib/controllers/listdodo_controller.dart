import 'dart:convert';
import 'dart:core';

import 'package:nylo_framework/nylo_framework.dart';

import '../config/storage_keys.dart';
import '../models/Todo.dart';
import 'controller.dart';

class ListTodoController extends Controller {
  Future<List<Todo>>? list() async {
    List<Todo>? list = [];
    var todoStorage = await NyStorage.read(StorageKey.listTodo);

    final decodeData = jsonDecode(todoStorage) as List;
    list = decodeData.map<Todo>((e) => Todo.fromJson(e)).toList();
    return list ?? [];
  }
}
