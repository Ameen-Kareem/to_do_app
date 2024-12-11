import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:to_do_app/global_widgets/common_button.dart';
import 'package:to_do_app/view/add_task_screen/add_task_screen.dart';

class UpdateTaskScreen extends StatefulWidget {
  UpdateTaskScreen({super.key, required this.index});
  int index;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late int index;
  void initState() {
    super.initState();
    index = widget.index;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _updatedDate;
  TimeOfDay? _updatedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text("Update Task"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Column(
              children: [
                //title for the task
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the title of the task';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //description of the task
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the description of the task';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                //Date picker
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _updatedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _updatedDate) {
                      setState(() {
                        _updatedDate = pickedDate;
                      });
                    }
                    log(_updatedDate.toString());
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Deadline Date',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    child: Text(
                      _updatedDate == null
                          ? 'Select Date'
                          : _updatedDate!.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //Time picker
                InkWell(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _updatedTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null && pickedTime != _updatedTime) {
                      setState(() {
                        _updatedTime = pickedTime;
                        log(_updatedTime.toString());
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Deadline Time',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    child: Text(
                      _updatedTime == null
                          ? 'Select Time'
                          : _updatedTime!.format(context),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //Buttons
                Row(children: [
                  //Updating task button
                  CommonButton(
                    content: "Update Task",
                    functionality: () async {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        String title = _titleController.text;
                        String description = _descriptionController.text;
                        DateTime? deadline =
                            _updatedDate != null && _updatedTime != null
                                ? DateTime(
                                    _updatedDate!.year,
                                    _updatedDate!.month,
                                    _updatedDate!.day,
                                    _updatedTime!.hour,
                                    _updatedTime!.minute,
                                  )
                                : null;

                        await HomeScreenController.updateTask(
                            deadline: deadline,
                            title: title,
                            description: description,
                            id: HomeScreenController.taskList[index]["id"]);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Task Udpated")));
                        setState(() {});
                        Navigator.pop(context);
                      } else {
                        log("Not validated");
                      }
                    },
                  ),
                ])
              ],
            ),
          )),
    );
  }
}
