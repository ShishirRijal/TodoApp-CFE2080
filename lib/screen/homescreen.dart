import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purpleAccent,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            // showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (context) => SingleChildScrollView(
            //         child:Container(
            //           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            //           child: AddTaskScreen(),
            //         )
            //     )
            // );
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todo App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Total Tasks: 20',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskTile(taskTitle: "Task $index");
                },
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
