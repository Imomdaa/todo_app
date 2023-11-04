import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/tasks/task_item.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors/app_colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: primaryColor,
          dayColor: primaryColor.withOpacity(.4),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: primaryColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        FutureBuilder(future: FirebaseFunctions.getTasks(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Text("Something went worng") ;
              }
              var tasks=snapshot.data?.docs.map((e) => e.data()).toList()??[];
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(taskModel: tasks[index],);
                  },
                  itemCount: tasks.length,
                ),
              );
            },)
      ],
    );
  }
}
