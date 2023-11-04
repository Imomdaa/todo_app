import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/tasks_model.dart';
import 'package:todo/shared/styles/colors/app_colors.dart';

import '../../shared/network/firebase/firebase_functions.dart';

class TaskItem extends StatefulWidget {
 TaskModel taskModel;


 TaskItem({required this.taskModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTasks(widget.taskModel.id);
              setState(() {

              });
            },
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                color: Colors.blue,
                height: 80,
                width: 5,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.taskModel.title,
                    style: GoogleFonts.quicksand(fontSize: 18),
                  ),
                  Text(widget.taskModel.description,
                      style: GoogleFonts.quicksand(fontSize: 14))
                ],
              ),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.taskModel.isDone?Colors.green : primaryColor,
                  ),
                  height: 40,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
