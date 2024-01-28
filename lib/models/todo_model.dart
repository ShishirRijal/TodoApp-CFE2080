import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String title;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  /// Change the value of [isCompleted] to the opposite of what it is.
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  /// [Fetch] all tasks from the database and return a [List] of [TodoModel].
  static Future<List<TodoModel>> fetchTasks() async {
    List<TodoModel> tasks = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    for (var doc in querySnapshot.docs) {
      tasks.add(TodoModel.fromJson(doc.data()));
    }
    return tasks;
  }

  /// [Add] a new task to the database.
  static void addTask(String task) async {
    String taskId = FirebaseFirestore.instance.collection('tasks').doc().id;

    await FirebaseFirestore.instance.collection('tasks').doc(taskId).set(
      {
        'id': taskId,
        'title': task,
        'isCompleted': false,
      },
    );
  }

  /// [Update] a task in the database.
  static void updateTask(TodoModel todo) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(todo.id)
        .update(todo.toJson());
  }

  /// [Delete] a task from the database.
  static void deleteTask(TodoModel todo) async {
    await FirebaseFirestore.instance.collection('tasks').doc(todo.id).delete();
  }

  /// [Create] a new [TodoModel] from a [Map] of data.
  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = json['isCompleted'];

  /// [Convert] a [TodoModel] to a [Map] of data.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };
}
