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

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  static Future<List<TodoModel>> fetchTasks() async {
    List<TodoModel> tasks = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    for (var doc in querySnapshot.docs) {
      tasks.add(TodoModel.fromJson(doc.data()));
    }
    return tasks;
  }

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

  static void updateTask(TodoModel todo) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(todo.id)
        .update(todo.toJson());
  }

  static void deleteTask(TodoModel todo) async {
    await FirebaseFirestore.instance.collection('tasks').doc(todo.id).delete();
  }

  // from json
  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = json['isCompleted'];
// to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };
}
