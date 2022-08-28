import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        var newTasks = AppCubit.get(context).newTasks;
        List<Map<dynamic,dynamic>> inProgress = [];
        List<Map<dynamic,dynamic>> scheduled = [];
        List<Map<dynamic,dynamic>> missed = [];

        newTasks.forEach((element) {
          if(element['currentStatus'] == 'In Progress')
            inProgress.add(element);
          else if(element['currentStatus'] == 'Scheduled')
            scheduled.add(element);
          else
            missed.add(element);
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateTime.now().hour >= 12
                            ? '''Good Afternoon sir
You have ${AppCubit.get(context).newTasks.length.toString()} tasks due today.'''
                            : '''Good Morning sir 
You have ${AppCubit.get(context).newTasks.length.toString()} tasks due today.''',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(width: 10,),
                    LottieBuilder.asset('assets/images/eaNo0izFfS.json'),
                  ],
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.lightGreen,
                    ),
                    Text(
                      ' In Progress',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child: homeTaskListBuilder(tasks: scheduled),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.yellow.shade600,
                    ),
                    Text(
                      ' Scheduled',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height:130,
                  child: homeTaskListBuilder(tasks: scheduled),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.redAccent,
                    ),
                    Text(
                      ' Missed Deadline',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height:130,
                  child: homeTaskListBuilder(tasks: scheduled),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
