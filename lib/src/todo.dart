// TODO make a provider
class Todo {
  Todo._(this.index, this.title, this.body);

  factory Todo(String title, String body) {
    return Todo._(
      nextIndex++,
      title,
      body,
    );
  }

  final String title;
  final String body;
  final int index;

  static int nextIndex = 0;
}
