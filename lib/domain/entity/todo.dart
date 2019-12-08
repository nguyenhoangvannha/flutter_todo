class Todo {
  int id;
  String title;
  bool completed;
  DateTime dateAdded;

  Todo(this.title, {this.completed = false, this.dateAdded, this.id}) {
    dateAdded = dateAdded ?? DateTime.now();
    this.id = this.id ?? dateAdded.millisecondsSinceEpoch;
  }
}
