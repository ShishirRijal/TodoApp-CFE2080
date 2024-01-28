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

List<TodoModel> _todos = [
  TodoModel(id: '1', title: "Code my portfolio website with flutter"),
  TodoModel(id: '2', title: "Solve one leetcode problem"),
  TodoModel(
      id: '3',
      title: "Write blog post about Dart programming",
      isCompleted: true),
  TodoModel(id: '1', title: "Make a todo app with flutter"),
  TodoModel(
      id: '2', title: "Learn a new programming language", isCompleted: true),
  TodoModel(id: '3', title: "Write blog post about Dart programming"),
  TodoModel(
      id: '4',
      title: "Complete online course on mobile app development",
      isCompleted: true),
  TodoModel(id: '5', title: "Prepare for technical interview questions"),
];

List<TodoModel> get todos => _todos;
