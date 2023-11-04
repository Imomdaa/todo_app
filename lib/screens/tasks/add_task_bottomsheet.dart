import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/tasks_model.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task ", style: GoogleFonts.elMessiri(fontSize: 25)),
            SizedBox(
              height: 30,
            ),
            TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.toString().length < 4)
                    return "Please Enter Title at least 4 char";
                },
                decoration: InputDecoration(
                  label: Text("Task Title"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: primaryColor)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                )),
            SizedBox(
              height: 17,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                label: Text("Task Description"),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Date",
                  style:
                      GoogleFonts.elMessiri(color: Colors.blue, fontSize: 18),
                )),
            InkWell(
                onTap: () {
                  ChooseDateTime();
                },
                child: Text(selectedDate.toString().substring(0, 10))),
            ElevatedButton(
                onPressed: () {
                  TaskModel task = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateUtils.dateOnly(selectedDate)
                          .millisecondsSinceEpoch);
                  print(selectedDate);
                  FirebaseFunctions.addTask(task);
                  Navigator.pop(context);
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void ChooseDateTime() async {
    DateTime? chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chooseDate != null) {
      selectedDate = chooseDate;
      setState(() {});
    }
  }
}
