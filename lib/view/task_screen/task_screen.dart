import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:to_do_app/global_widgets/common_button.dart';
import 'package:to_do_app/update_task_screen/update_task_screen.dart';
import 'package:to_do_app/view/add_task_screen/add_task_screen.dart';
import 'package:to_do_app/view/task_details_screen/task_details_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await HomeScreenController.getTask();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )),
      ),
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: HomeScreenController.taskList.length == 0
                  ? Center(child: Text("Add Some tasks"))
                  : ListView.separated(
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskDetailsScreen(
                                    index: index,
                                  ),
                                ));
                          },
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(HomeScreenController.taskList[index]
                                          ["title"]
                                      .toString()),
                                  Text(
                                    HomeScreenController.taskList[index]
                                            ["description"]
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateTaskScreen(
                                        index: index,
                                      ),
                                    )),
                                child: Icon(Icons.edit),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  await HomeScreenController.deleteTask(
                                      HomeScreenController.taskList[index]
                                          ["id"]);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: HomeScreenController.taskList.length,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: Text("Tasks"),
  );
}
