class Todo {
  int id;
  String title;
  bool completed;
  DateTime dateAdded;

  Todo(this.title, {this.completed = false}) {
    dateAdded = DateTime.now();
    this.id = dateAdded.millisecondsSinceEpoch;
  }
}
