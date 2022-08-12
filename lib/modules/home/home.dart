import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        var archivedTasks = AppCubit.get(context).archivedTasks;
        var doneTasks = AppCubit.get(context).trash;

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
                    Icon(Icons.grid_view, color: Colors.blue, size: 80,)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Text(
                      'To Do Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      'Expand All',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(height: 130, child: homeTaskListBuilder(tasks: newTasks)),
                SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Text(
                      'Done Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      'Expand All',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child: ConditionalBuilder(
                    condition: AppCubit.get(context).trash.isNotEmpty,
                    builder: (context) => homeTaskListBuilder(tasks: doneTasks),
                    fallback: (context) => Center(child: Icon(Icons.info_outline, size: 30,),),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Text(
                      'Archived Tasks',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      'Expand All',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Container(
                  height: 130,
                  child:ConditionalBuilder(
                    condition: AppCubit.get(context).archivedTasks.isNotEmpty,
                    builder: (context) => homeTaskListBuilder(tasks: archivedTasks),
                    fallback: (context) => Center(child: Icon(Icons.info_outline, size: 30,),),
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
