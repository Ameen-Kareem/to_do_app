import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:to_do_app/view/add_task_screen/add_task_screen.dart';
import 'package:to_do_app/view/task_screen/task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    String date = HomeScreenController.taskList[index]["deadline"]
        .toString()
        .split(' ')[0]; // Gets the date part
    // DateTime datePart = DateTime.parse(date);
    // String formattedDate = DateFormat('dd/MM/yyyy').format(datePart);

    // Format the time as "HH:mm:ss"
    String time = HomeScreenController.taskList[index]["deadline"]
        .toString()
        .split(' ')[1]; // Gets the time part
    // DateTime timePart = DateTime.parse(time);
    // String formattedTime = DateFormat('HH:mm:ss').format(timePart);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${HomeScreenController.taskList[index]["title"].toString()[0].toUpperCase()}${HomeScreenController.taskList[index]["title"].toString().substring(1)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                HomeScreenController.taskList[index]["description"].toString(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Last Date:$date"),
              SizedBox(
                height: 20,
              ),
              Text("Deadline time:$time")
            ],
          ),
        ),
      ),
    );
  }
}
