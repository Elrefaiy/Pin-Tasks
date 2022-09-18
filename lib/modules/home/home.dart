import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/conistants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {

  static List<Map<dynamic,dynamic>> todayTasks = [];
  static List<Map<dynamic,dynamic>> inProgress = [];
  static List<Map<dynamic,dynamic>> scheduled = [];
  static List<Map<dynamic,dynamic>> missed = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state){

        var newTasks = AppCubit.get(context).newTasks;
        todayTasks = [];
        inProgress = [];
        scheduled = [];
        missed = [];
        String currentTime = TimeOfDay(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute,
        ).format(context).toString();

        newTasks.forEach((element) {
          if(element['date'] == DateTime.now().toString().substring(0,11))
            todayTasks.add(element);
        });

        todayTasks.forEach((element) {
          if(element['startTime'] == currentTime || element['currentStatus'] == 'In Progress'){
            AppCubit.get(context).updateTaskCurrentStatus(
              currentStatus: 'In Progress',
              id: element['id'],
            );
            inProgress.add(element);
          }
          else if(hourParser(element['deadline']) < DateTime.now().hour || element['currentStatus'] == 'Missed Deadline'){
            AppCubit.get(context).updateTaskCurrentStatus(
              currentStatus: 'Missed Deadline',
              id: element['id'],
            );
            missed.add(element);
          }
          else if(element['currentStatus'] == 'Scheduled')
            scheduled.add(element);
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                //Greeting
                Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey[800]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(.1)
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateTime.now().hour >= 12
                              ? 'Good afternoon sir, You have ${todayTasks.length.toString()} tasks due today.'
                              : 'Good morning sir, You have ${todayTasks.length.toString()} tasks due today.',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(width: 10,),
                      LottieBuilder.asset(
                        DateTime.now().hour >= 12
                            ? 'assets/images/weather-cloudynight.json'
                            : 'assets/images/sunclouds.json' ,
                        width: 150,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //In Progress
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.blue,
                    ),
                    Text(
                      ' In Progress',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${inProgress.length.toString()} Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child: ConditionalBuilder(
                    condition: inProgress.length > 0,
                    builder: (context)=> homeTaskListBuilder(tasks: inProgress),
                    fallback: (context)=> Image(
                      image: AssetImage('assets/images/noInProgress.png',),
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Scheduled
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.yellow.shade600,
                    ),
                    Text(
                      ' Scheduled',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${scheduled.length.toString()} Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child: ConditionalBuilder(
                    condition: scheduled.length > 0,
                    builder: (context)=> homeTaskListBuilder(tasks: scheduled),
                    fallback: (context)=> Image(
                      image: AssetImage('assets/images/noScheduled.png',),
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //Missed Deadline
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.redAccent,
                    ),
                    Text(
                      ' Missed Deadline',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${missed.length.toString()} Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child: ConditionalBuilder(
                    condition: missed.length > 0,
                    builder: (context)=> homeTaskListBuilder(tasks: missed),
                    fallback: (context)=> Image(
                      image: AssetImage('assets/images/noMissed.png',),
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
