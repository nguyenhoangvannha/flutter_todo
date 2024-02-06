class Todo {
  String id;
  String title;
  bool completed;
  DateTime dateAdded;

  Todo(this.title,
      {this.completed = false, required this.dateAdded, required this.id});
}
