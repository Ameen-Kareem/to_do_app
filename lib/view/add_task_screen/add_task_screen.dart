import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:to_do_app/global_widgets/common_button.dart';
import 'package:to_do_app/view/task_screen/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              taskDetails(),
              SizedBox(height: 20),
              deadlineSelector(),
              SizedBox(height: 20),
              Row(
                children: [
                  CommonButton(
                    content: "Add Task",
                    functionality: () async {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        String title = _titleController.text;
                        String description = _descriptionController.text;
                        DateTime? deadline =
                            _selectedDate != null && _selectedTime != null
                                ? DateTime(
                                    _selectedDate!.year,
                                    _selectedDate!.month,
                                    _selectedDate!.day,
                                    _selectedTime!.hour,
                                    _selectedTime!.minute,
                                  )
                                : null;

                        await HomeScreenController.addTask(
                            deadline, title, description);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Task Added")));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget taskDetails() {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter the title of the task';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter the description of the task';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget deadlineSelector() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Deadline Date',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: Text(
              _selectedDate == null
                  ? 'Select Date'
                  : _selectedDate!.toLocal().toString().split(' ')[0],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
            );
            if (pickedTime != null && pickedTime != _selectedTime) {
              setState(() {
                _selectedTime = pickedTime;
              });
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Deadline Time',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: Text(
              _selectedTime == null
                  ? 'Select Time'
                  : _selectedTime!.format(context),
            ),
          ),
        ),
      ],
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    leading: InkWell(
      child: Icon(
        Icons.arrow_back,
      ),
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(),
          )),
    ),
    title: Text("Add Task"),
  );
}
