class Todo {

  final int id;
  final String description;
  final bool completed;

  const Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });
}