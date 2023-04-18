import 'package:nylo_framework/nylo_framework.dart';

class Todo extends Storable {
  int id;
  String description;
  bool completed;

  Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        description: json["description"],
      );

  @override
  Map<String, dynamic> toStorage() => {
        "description": this.description,
        "id": this.id,
        "completed": this.completed
      };

  @override
  fromStorage(dynamic data) {
    this.description = data['description'];
    this.id = data['id'];
    this.completed = data['completed'];
  }
}
